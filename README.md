# PlayFab to Supabase Porting
**A full, comprehensive guide and SDK wrapper for migrating Unity games from PlayFab to Supabase.**

## Why?
**PlayFab recently limited their free tier to a maximum of 1k users, a massive drop from the 100k users previously available.** As they transition from **Development Mode** to **Foundation Mode**, developers are being squeezed into expensive paid tiers. Until PlayFab restores the accessibility that helped indie developers grow, this repository will remain an active, open-source alternative.

## The Architecture
Supabase is a **Backend as a Service (BaaS)** powered by **PostgreSQL**. While PlayFab is a **Gaming Backend (GBaaS)**, we can replicate its gaming features (Leaderboards, Economy, Inventories) using Supabase's Relational Database and Edge Functions.



## Key Features
* **Device-Based Auth:** Replicates PlayFab's `LoginWithCustomID` using `SystemInfo.deviceUniqueIdentifier`.
* **Relational Data:** Moves away from PlayFab's messy JSON blobs to structured SQL tables.
* **Edge Logic:** Uses Supabase Edge Functions (TypeScript) to replace PlayFab CloudScript for secure, server-side operations.
* **Realtime Meta:** Leverages Supabase Realtime for friend lists and global alerts, keeping Photon focused strictly on high-tick physics.

## Quick Start
1.  **Database Setup:** Run the provided `schema.sql` in your Supabase SQL Editor to generate the `profiles`, `inventories`, and `leaderboards` tables.
2.  **Unity Integration:** Drop the `SupabaseWrapper` folder into your `Assets` directory.
3.  **Configuration:** Update the `SupabaseConfig` ScriptableObject with your Supabase URL and Anon Key.
4.  **Authentication:**
    ```csharp
    await SupabaseManager.Instance.LoginWithDevice();
    ```

## Security & Best Practices
* **Row Level Security (RLS):** All provided SQL templates include RLS policies to ensure players can only modify their own stats and inventories.
* **No Hardcoded Secrets:** This wrapper is designed to work with the **Anon Key** only. Sensitive operations (like adding currency) are handled via **Edge Functions** to prevent client-side hacking.

## Who?
This repository is a community effort to combat PlayFab's restrictions. It is actively maintained by **Polar** and a group of developers dedicated to keeping indie game backends open and affordable.

## Contributors

<table align="center">
  <tr>
    <td align="center" valign="center">
      <a href="https://github.com/polardev-ui">
        <img src="https://avatars.githubusercontent.com/u/215530509?v=4" width="100px;" style="border-radius: 50%;" alt="Polar"/><br />
        <sub><b>Polar</b></sub>
      </a>
    </td>
    <td align="center" valign="center">
      <a href="https://github.com/celestriaontop">
        <img src="https://github.com/celestriaontop.png" width="100px;" style="border-radius: 50%;" alt="H1unter"/><br />
        <sub><b>H1unter</b></sub>
      </a>
    </td>
    <td align="center" valign="center">
      <a href="https://github.com/compassplate">
        <img src="https://avatars.githubusercontent.com/u/270543794?v=4" width="100px;" style="border-radius: 50%; aspect-ratio: 1/1; object-fit: cover;" alt="compassplate"/><br />
        <sub><b>compassplate</b></sub>
      </a>
    </td>
  </tr>
</table>

## License
This project is licensed under the **GNU GPL v3**. This ensures that the core porting logic remains open-source and free for all developers, preventing any single entity from privatizing this community resource.