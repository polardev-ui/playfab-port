# SupabaseWrapper for Unity
**The open-source alternative to PlayFab's restricted tiers.**

This wrapper is designed to replace the core functionality of PlayFab with **Supabase**, providing a scalable PostgreSQL backend with Row Level Security (RLS). 

## Folder Structure
To ensure this tool is useful for both the "Gorilla Tag" modding community and general indie devs, the wrapper is split into two modules:

* **`/Core`**: The engine. Contains the `SupabaseManager` singleton.
* **`/Copy`**: Specialized scripts for **Gorilla Tag replicas**. Uses Device ID auth and mirrors `GorillaComputer` variables (Colors, Turn speeds, Comp Queue).
* **`/General`**: Standard boilerplate for any Unity project (Email/Password auth, XP, Level, and Currency).

---

## Setup Instructions

### 1. Supabase Dashboard Configuration
1.  Go to **Authentication > Providers**.
2.  Find **Email** and toggle **Confirm Email** to **OFF**. 
    * *Note: This is required for the Device ID auth in the `/Copy` folder to work without a real email address.*
3.  Run the `schema.sql` (found in the root of the GitHub repo) in your **SQL Editor**.

### 2. Unity Integration
1.  **Dependencies:** Ensure you have the `Supabase-C#` library installed (via NuGet or as a `.dll` in your Plugins folder).
2.  **Manager:** Attach `SupabaseManager.cs` to a GameObject in your loading scene.
3.  **Config:** Paste your `Supabase URL` and `Anon Key` into the `SupabaseManager` inspector fields.

---

## Usage

### For Gorilla Tag Replicas (`/Copy`)
To replace your `PlayFabAuthenticator.cs` logic, call the GorillaAuth method:

```csharp
public async void StartLogin() {
    bool success = await GetComponent<GorillaAuth>().AuthenticateGorilla();
    if(success) {
        Debug.Log("Monkey Authenticated via Supabase!");
        // proceed to Photon connection (different for each update)
    }
}
```

### For General Games (/General)
Standard email-based authentication:

```csharp 
await generalAuth.SignUp("player@gorilla.com", "Password123", "PlayerName");

await generalAuth.SignIn("player@gorilla.com", "Password123");
```

*If you add features like secure Trading or more complex Inventories, please contribute back to the repo!*