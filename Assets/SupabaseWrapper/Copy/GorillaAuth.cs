using UnityEngine;
using System.Threading.Tasks;
using System.IO;

public class GorillaAuth : MonoBehaviour
{
    public async Task<bool> AuthenticateGorilla()
    {
        // 1. get the unique id
        string deviceID = SystemInfo.deviceUniqueIdentifier;
        string fakeEmail = $"{deviceID}@gorilla.com"; // preferrably keep this consistent with your backend logic, this is just an example, not needed tho
        string password = "DefaultPassword123!"; // you can obfuscate this dw

        try
        {
            // 2. attempt auth
            var session = await SupabaseManager.Client.Auth.SignIn(fakeEmail, password);
            Debug.Log($"Gorilla Authenticated: {session.User.Id}");
            return true;
        }
        catch
        {
            // 3. if failed, sign up
            var session = await SupabaseManager.Client.Auth.SignUp(fakeEmail, password);
            Debug.Log("New Gorilla Account Created");
            return session != null;
        }
    }
}