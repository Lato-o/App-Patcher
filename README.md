# ReVanced Builds

<!--
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/rvc_magisk)
[![CI](https://github.com/j-hc/revanced-magisk-module/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/j-hc/revanced-magisk-module/actions/workflows/ci.yml)
-->

Extensive ReVanced builder

Get the [latest CI release](https://github.com/Lato-o/Revanced-Builder/releases).

Use [**zygisk-detach**](https://github.com/j-hc/zygisk-detach) to detach YouTube and YT Music from Play Store if you are using magisk modules.

<!--
<details><summary><big>Features</big></summary>
<ul>
 <li>Support all present and future ReVanced and <a href="https://github.com/inotia00/revanced-patches">ReVanced Extended</a> apps</li>
 <li> Can build Magisk modules and non-root APKs</li>
 <li> Updated daily with the latest versions of apps and patches</li>
 <li> Optimize APKs and modules for size</li>
 <li> Modules</li>
    <ul>
     <li> recompile invalidated odex for faster usage</li>
     <li> receive updates from Magisk app</li>
     <li> do not break safetynet or trigger root detections</li>
     <li> handle installation of the correct version of the stock app and all that</li>
     <li> support Magisk and KernelSU</li>
    </ul>
</ul>
Note that the <a href="../../actions/workflows/ci.yml">CI workflow</a> is scheduled to build the modules and APKs everyday using GitHub Actions if there is a change in ReVanced patches. You may want to disable it.
</details>
-->

## Installation

### Available Applications

| Application    | Type                      | Patches Provider                                                          | Patch Version                      | File   |
| -------------- | ------------------------- | ------------------------------------------------------------------------- | ---------------------------------- | ------ |
| **YouTube**    | Magisk Module (Root only) | [anddea/revanced-patches](https://github.com/anddea/revanced-patches)     | `dev` (latest development version) | `.zip` |
| **SoundCloud** | APK (Non-root)            | [revanced/revanced-patches](https://github.com/revanced/revanced-patches) | `latest` (latest stable version)   | `.apk` |

### Installation Instructions

#### YouTube (Magisk Module - Root only)

1. **Important:** Uninstall the original YouTube app from your device before proceeding
   - Go to **Settings** → **Apps** → **YouTube** → **Uninstall**
   - If you cannot uninstall it (system app), disable it instead
2. Download the `.zip` file from the [releases page](https://github.com/Lato-o/Revanced-Builder/releases)
   - Look for the file `youtube-revanced-extended-magisk-*.zip`
3. Open the **Magisk Manager** app
4. Go to the **Modules** tab
5. Click on **Install from storage**
6. Select the downloaded `.zip` file
7. Reboot your device
8. The module will automatically receive updates through Magisk Manager when new versions are available

> **Note:** Make sure you have Magisk or KernelSU installed on your device. The module requires root access.

#### SoundCloud (APK - Non-root)

1. Download the `.apk` file from the [releases page](https://github.com/Lato-o/Revanced-Builder/releases)
   - Look for the file `soundcloud-revanced-*.apk`
2. On your Android device, enable installation from unknown sources:
   - Go to **Settings** → **Security** → Enable **Unknown sources** (or **Install unknown apps** depending on your Android version)
3. Open the downloaded `.apk` file
4. Follow the on-screen instructions to install the application
5. Once installed, you can disable installation from unknown sources

> **Note:** If you already have SoundCloud installed from the Play Store, you must uninstall it first before installing the patched version.


Also see [`config.toml`](./config.toml) for more information.

<!--
## Building Locally

### On Termux

```console
bash <(curl -sSf https://raw.githubusercontent.com/j-hc/revanced-magisk-module/main/build-termux.sh)
```

### On Desktop

```console
$ git clone https://github.com/j-hc/revanced-magisk-module
$ cd revanced-magisk-module
$ ./build.sh
```
-->
