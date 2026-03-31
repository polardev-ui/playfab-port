using UnityEngine;
using Supabase;
using System.Threading.Tasks;

public class SupabaseManager : MonoBehaviour
{
    public static Supabase.Client Client { get; private set; }
    public static SupabaseManager Instance { get; private set; }

    [Header("Configuration")]
    public string supabaseUrl = "https://your-project.supabase.co";
    public string supabaseAnonKey = "your-anon-key";

    void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
            
            var options = new SupabaseOptions { AutoRefreshToken = true };
            Client = new Supabase.Client(supabaseUrl, supabaseAnonKey, options);
        }
        else { Destroy(gameObject); }
    }
}