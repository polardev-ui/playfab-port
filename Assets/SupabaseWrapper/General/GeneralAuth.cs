using UnityEngine;
using System.Threading.Tasks;

public class GeneralAuth : MonoBehaviour
{
    public async Task<bool> SignUp(string email, string password, string username)
    {
        var metadata = new System.Collections.Generic.Dictionary<string, object> {
            { "username", username }
        };
        
        var session = await SupabaseManager.Client.Auth.SignUp(email, password, new Supabase.Gotrue.SignUpOptions { Data = metadata });
        return session != null;
    }

    public async Task<bool> SignIn(string email, string password)
    {
        var session = await SupabaseManager.Client.Auth.SignIn(email, password);
        return session != null;
    }
}