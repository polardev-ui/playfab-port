# PlayFab to Supabase porting
**This is a full, comprehensive guide to changing your Unity game from PlayFab to Supabase**

## Why?
**PlayFab recently limited their free tier to allow users to have a maximum of 1k users, instead of the old 100k users that we generously got for free.**
**Until PlayFab decides to update their app and restore the 100k users we once had, this repository stays open and active.**
**We only know that PlayFab did this because they're switching from Development Mode to Foundation Mode, forcing people to pay for their paid plans/tiers.**

## How?
**Supabase uses Restful API's and Postgres, which isn't all that different to PlayFab. If anything, it's more customizable and secure by default.**
**Supabase is a Backend as a Service (BaaS), and PlayFab is a Gaming Backend as a Service (GBaaS), meaning we get the same features, except for things like Leaderboard, Economy, Catalogs, etc.**
**Unity can collect data from Meta and Pico devices using `SystemInfo.deviceUniqueIdentifier` which is an easy way to get a unique string identifier for that user and device, allowing us to put that string into a fake email and an administrator password (set by you) for all accounts, allowing users to authenticate as they would if this were a web application.**

## Who?
**This repository is actively being worked on and contributed to by several well known developers, including myself (polar) and we're working on this to combat PlayFabs restrictions.**
**You can view all the contributors at the bottom of this file.**

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