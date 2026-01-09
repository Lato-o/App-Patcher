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
| **YouTube** (ReVanced Extended) | Magisk Module (Root only) | [anddea/revanced-patches](https://github.com/anddea/revanced-patches)     | `dev` (latest development version) | `.zip` |
| **YouTube Music** (ReVanced Extended) | Magisk Module (Root only) | [anddea/revanced-patches](https://github.com/anddea/revanced-patches)     | `dev` (latest development version) | `.zip` |
| **YouTube** (Morphe) | Magisk Module & APK | [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches)     | `dev` (latest development version) | `.zip` / `.apk` |
| **YouTube Music** (Morphe) | APK (Non-root) | [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches)     | `v1.2.1-dev.2` | `.apk` |
| **SoundCloud** | APK (Non-root)            | [revanced/revanced-patches](https://github.com/revanced/revanced-patches) | `latest` (latest stable version)   | `.apk` |

### Applied Patches

> **Note:** For the complete and up-to-date list of all available patches, please refer to the official patch repositories:
> - [anddea/revanced-patches](https://github.com/anddea/revanced-patches) - [Full patch list](https://github.com/anddea/revanced-patches#-patches)
> - [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches) - [Full patch list](https://github.com/MorpheApp/morphe-patches)
> - [ReVanced/revanced-patches](https://github.com/ReVanced/revanced-patches) - [Full patch list](https://github.com/ReVanced/revanced-patches#-patches)

#### YouTube (ReVanced Extended)

**Configuration:**
- **Included Patches (whitelist):**
  - Custom header for YouTube
  - Hide Shorts dimming
  - Hide shortcuts
  - MaterialYou
- **Excluded Patches:**
  - Custom branding icon for YouTube
  - Custom branding name for YouTube
- **Additional Options:**
  - Visual preferences icons: gear icon
  - Settings label: "ReVanced Extended"
  - Dark theme background color: black

**Available Patches from [anddea/revanced-patches](https://github.com/anddea/revanced-patches):**

The following patches are available for YouTube (com.google.android.youtube). Only the patches listed above are included in this build:

<details>
<summary><b>Click to expand full patch list</b></summary>

**Ad & Tracking:**
- Hide ads
- Hide general ads
- Hide movie ads
- Hide web search results
- Hide video ads
- Remove tracking query parameter

**Layout & UI:**
- Alternative thumbnails
- Change start page
- Custom branding icon for YouTube
- Custom branding name for YouTube
- Custom video speed
- Disable auto captions
- Disable fullscreen mode
- Disable landscape mode
- Disable seekbar tapping
- Disable suggested video end screen
- Disable suggested videos
- Enable tablet layout
- Hide action buttons
- Hide album cards
- Hide autoplay button
- Hide breaking news shelf
- Hide captions button
- Hide cast button
- Hide channel avatar section
- Hide channel list
- Hide comments section
- Hide create button
- Hide crowdfunding box
- Hide email address
- Hide endscreen cards
- Hide expandable chip
- Hide filter bar
- Hide floating microphone button
- Hide info cards
- Hide layout components
- Hide live chat
- Hide mix playlist
- Hide navigation buttons
- Hide player buttons
- Hide player overlay filter
- Hide quick actions
- Hide related videos
- Hide search term suggestions
- Hide seekbar
- Hide shorts components
- Hide shorts navigation button
- Hide snackbar
- Hide start up shorts shelf
- Hide suggested actions
- Hide video action buttons
- MaterialYou
- Minimize player on tap
- Old quality layout
- Remember video quality
- Remove viewer discretion dialog
- Return YouTube Dislike
- Seekbar tapping
- Settings
- Spoof app version
- Swipe controls

**Playback:**
- Background playback
- Disable auto player popup panels
- Disable playback speed
- Disable video playback speed
- Enable wide search bar
- Force video codec
- Override resuming playback
- Remove background playback restrictions
- Remove player controls background
- Restore old seekbar thumbnails
- Video buffer
- Video quality

**Shorts:**
- Hide Shorts components
- Hide Shorts dimming
- Hide Shorts navigation button
- Hide Shorts shelf
- Hide Shorts tab

**Other:**
- Custom playback speed
- Custom video buffer
- Disable auto captions
- Disable suggested video end screen
- Hide action buttons
- Hide album cards
- Hide autoplay button
- Hide breaking news shelf
- Hide captions button
- Hide cast button
- Hide channel avatar section
- Hide channel list
- Hide comments section
- Hide create button
- Hide crowdfunding box
- Hide email address
- Hide endscreen cards
- Hide expandable chip
- Hide filter bar
- Hide floating microphone button
- Hide info cards
- Hide layout components
- Hide live chat
- Hide mix playlist
- Hide navigation buttons
- Hide player buttons
- Hide player overlay filter
- Hide quick actions
- Hide related videos
- Hide search term suggestions
- Hide seekbar
- Hide shorts components
- Hide shorts navigation button
- Hide snackbar
- Hide start up shorts shelf
- Hide suggested actions
- Hide video action buttons
- MaterialYou
- Minimize player on tap
- Old quality layout
- Remember video quality
- Remove viewer discretion dialog
- Return YouTube Dislike
- Seekbar tapping
- Settings
- Spoof app version
- Swipe controls

*Note: This is a partial list. For the complete and up-to-date list, visit the [official repository](https://github.com/anddea/revanced-patches#-comgoogleandroidyoutube).*

</details>

#### YouTube Music (ReVanced Extended)

**Configuration:**
- **Included Patches (whitelist):**
  - Custom header for YouTube Music
  - Disable music video in album
  - Hide overlay filter
  - Hide player overlay filter
- **Excluded Patches:**
  - Dark theme
  - Custom branding name for YouTube Music
- **Additional Options:**
  - Visual preferences icons: gear icon
  - Settings label: "ReVanced Extended"

**Available Patches from [anddea/revanced-patches](https://github.com/anddea/revanced-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

**Ad & Tracking:**
- Hide ads
- Remove tracking query parameter

**Layout & UI:**
- Bitrate default value
- Change start page
- Custom branding icon for YouTube Music
- Custom branding name for YouTube Music
- Disable auto captions
- Disable music video in album
- Disable suggested video end screen
- Disable suggested videos
- Enable tablet layout
- Hide action buttons
- Hide album cards
- Hide autoplay button
- Hide breaking news shelf
- Hide captions button
- Hide cast button
- Hide channel avatar section
- Hide channel list
- Hide comments section
- Hide create button
- Hide crowdfunding box
- Hide email address
- Hide endscreen cards
- Hide expandable chip
- Hide filter bar
- Hide floating microphone button
- Hide info cards
- Hide layout components
- Hide live chat
- Hide mix playlist
- Hide navigation buttons
- Hide player buttons
- Hide player overlay filter
- Hide quick actions
- Hide related videos
- Hide search term suggestions
- Hide seekbar
- Hide shorts components
- Hide shorts navigation button
- Hide snackbar
- Hide start up shorts shelf
- Hide suggested actions
- Hide video action buttons
- MaterialYou
- Minimize player on tap
- Old quality layout
- Remember video quality
- Remove viewer discretion dialog
- Return YouTube Dislike
- Seekbar tapping
- Settings
- Spoof app version
- Swipe controls

**Playback:**
- Background playback
- Disable auto player popup panels
- Disable playback speed
- Disable video playback speed
- Enable wide search bar
- Force video codec
- Override resuming playback
- Remove background playback restrictions
- Remove player controls background
- Restore old seekbar thumbnails
- Video buffer
- Video quality

**Other:**
- Custom playback speed
- Custom video buffer
- Disable auto captions
- Disable suggested video end screen
- Hide action buttons
- Hide album cards
- Hide autoplay button
- Hide breaking news shelf
- Hide captions button
- Hide cast button
- Hide channel avatar section
- Hide channel list
- Hide comments section
- Hide create button
- Hide crowdfunding box
- Hide email address
- Hide endscreen cards
- Hide expandable chip
- Hide filter bar
- Hide floating microphone button
- Hide info cards
- Hide layout components
- Hide live chat
- Hide mix playlist
- Hide navigation buttons
- Hide player buttons
- Hide player overlay filter
- Hide quick actions
- Hide related videos
- Hide search term suggestions
- Hide seekbar
- Hide shorts components
- Hide shorts navigation button
- Hide snackbar
- Hide start up shorts shelf
- Hide suggested actions
- Hide video action buttons
- MaterialYou
- Minimize player on tap
- Old quality layout
- Remember video quality
- Remove viewer discretion dialog
- Return YouTube Dislike
- Seekbar tapping
- Settings
- Spoof app version
- Swipe controls

*Note: This is a partial list. For the complete and up-to-date list, visit the [official repository](https://github.com/anddea/revanced-patches#-comgoogleandroidappsyoutubemusic).*

</details>

#### YouTube (Morphe)

**Configuration:**
- **Excluded Patches:**
  - Custom branding name for YouTube
  - Custom branding icon for YouTube
- **Included Patches:** All other available patches from MorpheApp are included by default

**Available Patches from [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

*Note: The complete list of patches for MorpheApp is available in the [official repository](https://github.com/MorpheApp/morphe-patches). All patches are included by default except for the branding patches listed above.*

**Common patches include:**
- Hide ads
- Background playback
- SponsorBlock integration
- Return YouTube Dislike
- Custom playback speed
- Video quality options
- Hide UI components
- And many more...

*For the complete and up-to-date list, please visit the [MorpheApp patches repository](https://github.com/MorpheApp/morphe-patches).*

</details>

#### YouTube Music (Morphe)

**Configuration:**
- **Excluded Patches:**
  - Custom branding name for YouTube Music
  - Custom branding icon for YouTube Music
- **Included Patches:** All other available patches from MorpheApp are included by default

**Available Patches from [MorpheApp/morphe-patches](https://github.com/MorpheApp/morphe-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

*Note: The complete list of patches for MorpheApp is available in the [official repository](https://github.com/MorpheApp/morphe-patches). All patches are included by default except for the branding patches listed above.*

**Common patches include:**
- Hide ads
- Background playback
- Custom playback speed
- Video quality options
- Hide UI components
- And many more...

*For the complete and up-to-date list, please visit the [MorpheApp patches repository](https://github.com/MorpheApp/morphe-patches).*

</details>

#### SoundCloud

**Configuration:**
- **Included Patches:** All available patches from ReVanced are included by default (no specific inclusions/exclusions configured)

**Available Patches from [ReVanced/revanced-patches](https://github.com/ReVanced/revanced-patches):**

<details>
<summary><b>Click to expand full patch list</b></summary>

*Note: The complete list of patches for SoundCloud is available in the [official ReVanced repository](https://github.com/ReVanced/revanced-patches). All patches are included by default.*

**Common patches include:**
- Hide ads
- Unlock premium features
- Custom theme
- And more...

*For the complete and up-to-date list, please visit the [ReVanced patches repository](https://github.com/ReVanced/revanced-patches).*

</details>

### Installation Instructions

#### YouTube (ReVanced Extended) - Magisk Module

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

#### YouTube Music (ReVanced Extended) - Magisk Module

1. **Important:** Uninstall the original YouTube Music app from your device before proceeding
   - Go to **Settings** → **Apps** → **YouTube Music** → **Uninstall**
   - If you cannot uninstall it (system app), disable it instead
2. Download the `.zip` file from the [releases page](https://github.com/Lato-o/Revanced-Builder/releases)
   - Look for the file `youtube-music-revanced-extended-magisk-*.zip`
3. Open the **Magisk Manager** app
4. Go to the **Modules** tab
5. Click on **Install from storage**
6. Select the downloaded `.zip` file
7. Reboot your device
8. The module will automatically receive updates through Magisk Manager when new versions are available

> **Note:** Make sure you have Magisk or KernelSU installed on your device. The module requires root access.

#### YouTube (Morphe) - Magisk Module or APK

**For Magisk Module (Root):**
1. Follow the same steps as YouTube (ReVanced Extended) above
2. Look for the file `youtube-morphe-magisk-*.zip`

**For APK (Non-root):**
1. Download the `.apk` file from the [releases page](https://github.com/Lato-o/Revanced-Builder/releases)
   - Look for the file `youtube-morphe-*.apk`
2. Enable installation from unknown sources on your device
3. Install the APK file
4. You may need [MicroG](https://github.com/ReVanced/GmsCore/releases) for non-root YouTube

#### YouTube Music (Morphe) - APK

1. Download the `.apk` file from the [releases page](https://github.com/Lato-o/Revanced-Builder/releases)
   - Look for the file `music-morphe-*.apk`
2. Enable installation from unknown sources on your device
3. Install the APK file
4. You may need [MicroG](https://github.com/ReVanced/GmsCore/releases) for non-root YouTube Music

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
