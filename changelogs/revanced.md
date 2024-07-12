# ReVanced changelog

## 2024-07-12
- **Client spoof**: Correctly play more livestreams using Android VR
- **Hide description components**: Replace **Hide game section** and **Hide music section** with **Hide attributes section**
- **Rename Minimized playback** to **Remove background playback restrictions**
- **Comments**: Add **Hide 'Create a Short' button**, **Hide Thanks button** and **Hide 'Comments by members' header** options
- **Miniplayer**: Rename **Tablet mini player** and allow selecting the style of the in-app miniplayer
- **Hide layout components**: Detect if a keyword filter hides all videos
- **Settings**: Move some settings to different menus, adjust default setting values
- **SponsorBlock**: Skip segments when casting

## 2024-06-02
- Updated to 19.16.39
- **Spoof client**: Spoof iOS client model to fix various side effects
- **Spoof client**: Allow swipe gestures to enter/exit fullscreen when spoofing with Android VR client
- **Spoof client**: Improve Android spoofing
- **Spoof client**: Restore playback speed menu when spoofing to an iOS client
- **Hide layout components**: Disable like / subscribe button glow animation
- **Playback speed**: Add option to show speed dialog button in video player

## 2024-05-21
- **Spoof client**: Spoof client to fix playback
- **Hide video action buttons**: Remove obsolete hide Shop button
- **Player flyout menu**: Remove obsolete Hide report menu
- **Restore old video quality menu**: Show advanced quality menu in Shorts quality flyout
- **SponsorBlock**: Show correct segment times if video is over 24 hours in length
- **Comments**: Add option to hide timestamp and emoji buttons
- **Hide ads**: Add option to hide the 'Visit store' button on channel pages
- **Hide Shorts components**: Hide 'Buy super thanks' button
- **Hide Shorts components**: Hide like / dislike button in video ads
- **Navigation buttons**: Add option to hide navigation button labels

## 2024-04-21
- Updated to 19.11.43
- Alternative thumbnails: Selectively enable for home / subscription / search
- GmsCore: Require ignoring battery optimizations
- GmsCore support: Prompt to disable battery optimizations, if not done already
- Hide ads: rename Hide paid content to Hide paid promotion label
- Hide load more button: Include patch with Hide layout components, and hide button only in search feed
- Hide Shorts components: Correctly hide Shorts if navigation tab is changed using device back button
- Player flyout menu: Add hide Lock screen menu
- Spoof device dimensions: Warn about potential performance issues
- Hide layout components: Add option to hide horizontal shelves
- Hide layout components: Hide playables
- Hide Shorts components: Hide Shop, Location and Save sound to playlist buttons
- Hide Shorts components: Hide tagged products, hide search suggestions
- Swipe controls: Save and restore brightness and add auto-brightness toggle
- Add 'About' preference to settings menu
- Match overlay icons style to YouTube

## 2024-03-28
- Updated to 19.09.37
- Client spoof: Spoof all user agents
- Hide ads: Prevent app crash if hiding fullscreen ads is not possible
- Fix video playback by switching to ReVanced GmsCore vendor
- Downloads: Use external downloader when selecting `Download` in home feed flyout menu
- Downloads: Add ability to use in-app download button
- Hide layout components: Filter home/search results by keywords
- Hide Shorts components: Hide like and dislike buttons
- Hide Shorts components: Hide sound metadata label
- Hide Shorts components: Hide title and full video link label
- Hide Shorts components: Selectively hide Shorts for home / subscription / search
- Remove HDR auto brightness patch

## 2024-03-04
- Spoof app version: Remove broken versions
- Spoof signature: Fix tracking such as history or watch time
- Change start page: Add more start pages
- Spoof app version: Add target versions
- Reorganize settings menu

## 2024-02-10
- Updated to 19.04.37
- Correctly show channel page on tablet devices

## 2024-01-30
- Updated to 19.03.35
- Minimized playback: Fix PIP incorrectly shown for some Shorts playback
- Return YouTube Dislike: Prevent the first Short opened from freezing the UI
- Alternative Thumbnails: Add option to use DeArrow
- Add Change start page patch
- Hide ads: Hide fullscreen ads
- Hide layout components: Hide search result recommendations
- Add Remove viewer discretion dialog patch (a07f83f)
- Remove Hide email address patch
- Clarify patch descriptions
- Enable slide to seek: Change patch default to excluded and add description disclaimer
- Change header: Change to ReVanced borderless logo header by default
- Other improvements to existing patches

## 2023-12-04
- Updated to 18.45.43

## 2023-11-25
- Updated to 18.45.41
- Hide layout components: Hide video quality menu footer
- Add Disable fullscreen ambient mode patch
- Add Disable suggested video end screen patch
- Add Enable old seekbar thumbnails patch
- SponsorBlock: Rename "Preview/Recap" category to "Preview/Recap/Hook"
- Rename Restore old seekbar thumbnails and Restore old quality menu
- Add Enable slide to seek patch
- Add Remove tracking query parameter patch
- ReturnYouTubeDislike: Improve layout padding
- Add Disable rolling number animations patch
- Hide ads: Hide shopping links in video description
- Hide layout components: Hide "For You" shelf in channel page

## 2023-10-27
- ReturnYouTubeDislike: Fix dislikes not showing on Shorts
- Hide layout components: Hide new channel watermark component
- Theme: Disable gradient loading screen
- Add Announcements patch
- Add Spoof device dimensions patch

## 2023-10-10
- Updated to 18.38.44
- Hide info cards: Fix info cards not hiding for some users
- Hide layout components: Always hide redundant 'player audio track' button
- Hide layout components: Hide "Join", "Notify me", search result shelf header and timed reactions
- Hide shorts components: Fix hiding navigation bar
- Restore functionality of Old video quality menu and Custom speeds on tablets
- Add Bypass URL redirects patch
- Add Disable fine scrubbing gesture patch
- Other improvements to existing patches

## 2023-09-07
- Updated to 18.32.39
- Allow setting no background color
- Apply custom seekbar color to shorts
- Add a switch to enable/disable custom seekbar color
- Add switch to hide chips shelf
- Add Player Flyout Menu patch
- Add switch to hide individual action buttons 
- Add Alternative thumbnails patch 
- Add Custom player overlay opacity patch 
- Add Enable tablet layout patch
- Restored original app name and icon

## 2023-07-18
- Updated to 18.23.35
- Remove non-functional custom video buffer patch
- Update app icon

## 2023-07-07
- Option to hide mix playlists
- Don't re-enable signature spoof automatically
- Enable predictive back gesture

## 2023-06-07
- Updated to 18.19.35
- Fix default video quality/speed being applied when resuming app
- Fix temporarily frozen video after opening a short
- Add tap and hold functionality to copy video URL buttons
- Add option to import/export ReVanced settings
- Add hide-load-more-button, hide-filter-bar and hide-shorts-components patches
- Use dynamic background color for custom splash screen
- Other fixes and improvements

## 2023-05-10
- Update to 18.16.37
- Disable debugging by default
- Fix hide action buttons not working for some users
- Remove hide-my-mix patch (broken)
- Disable minimized playback for shorts
- Add hide-player-overlay and navigation-button patches
- Fix background play of kids videos
- Other fixes and improvements

## 2023-04-22
- Update to 18.08.37
- Allow to not remember playback speed
- Automatic signature spoofing to prevent playback issues
- Change 'Hide create, clip and thanks buttons' to default off
- Fix 'Hide share button'
- Hide more types of ads
- Disable preferences and add dialog messages to preferences
- Change default video speed and quality inside the settings menu
- Various fixes and improvements to Sponsorblock and other patches

## 2023-03-18
### Patches v2.163.0
- `disable-fullscreen-panels-auto-popup`: use proper descriptions
- `general-ads`: fix switch description wording
- `hide-time`: use correct integrations class
- `hide-watch-in-vr`: fix descriptions
- `open-links-directly`: reference correct integrations method
- `general-ads`: hide channel bar
- `general-ads`: hide horizontal video shelf
- `open-links-directly`: skip every redirect url
### Patches v2.164.0
- `general-ads`: hide quick actions in fullscreen
- `general-ads`: hide related videos in quick action
- `return-youtube-dislike`: support for shorts
- Remove patch `open-links-directly`
### Patches v2.165.0
- `spoof-signature-verification` patch
### Patches v2.165.1
- `spoof-signature-verification`: use correct fingerprint
### Patches v2.166.0
- `general-ads`: remove duplicate preference
- `return-youtube-dislike`: add missing strings
- `custom-video-buffer`: replace patch with removal notice
- `disable-player-popup-panels`: use better patch description
- `general-ads`: do not hide components in library tab
- `general-ads`: hide image shelf from search results
- `hide-autoplay-button`: do not disable autoplay button when hidden
- `hide-floating-microphone-button`
- Bump compatibility to 18.05.40

## 2023-02-15
- `custom-branding`: correct scaling, margin and images
- `hide-player-buttons` patch
- `general-ads`: hide pill to view products
- `minimized-playback`: disable when playing shorts
- `general-ads`: use better description for switch
- `general-ads`: hide web search results

## 2023-01-30
- `return-youtube-dislike`: do not fetch voting stats when watching shorts
- `sponsorblock`: replace missing strings
- `general-ads`: remove hiding video shelf
- `open-links-externally` patch
- Show toasts along exceptions

## 2023-01-19
- Disabled predictive back gesture
- Added `hide-breaking-news-shelf`, `copy-video-url`, `remember-playback-rate` and `spoof-app-version` patches
- Improvements to existing patches

## 2022-12-24
- Updated base to 17.49.37
- Improvements to existing patches

## 2022-12-11
- Enabled predictive back gesture on Android 13
- Fixed swipe down to refresh
- Improvements to existing patches
- Re-enabled `theme` patch

## 2022-11-30
- Updated base to 17.45.36
- Added `open-links-directly` and `remove-player-button-background` patch
- Improvements to existing patches

## 2022-11-03
- Updated base to 17.43.36
- Added `hide-watch-in-vr` patch
- Updated Return YouTube Dislike to support new UI
- Hide Shorts comments button when hide comments is enabled

## 2022-10-28
- Updated base to 17.41.37
- Added the following patches: `hide-crowdfunding-box`, `hide-artist-card`, `hide-album-cards` and `comment`
- Re-added `hide-create-button`
- Changed default app name to ReVanced
- Use proper scaled icons
- Fixes and improvements to other patches

## 2022-10-21
- Added two new patches: `hide-my-mix` (removes mix playlists from the feed) and `hide-captions-button` (hides the captions button on video player)
- Temporarily excluded `hide-create-button` patch (conflicts with `hide-shorts-button` and makes the app crash)
- Various fixes and improvements to other patches

## 2022-10-06
- Added `disable-startup-shorts-player` and `hide-video-buttons` patches

## 2022-09-25
- Added `disable-auto-player-popup-panels` and `hide-time-and-seekbar` patches
- `custom-playback-speed`: max, min, granularity option
- Option to disable sponsorblock on shorts

## 2022-09-19
- Updated base to 17.36.37

## 2022-09-17
- Completely removed `amoled` from patches

## 2022-09-15
- Removed `amoled` patch since it's been deprecated by `theme`
- Added `disable-auto-captions` patch

## 2022-09-03
- Fixed download button color

## 2022-08-30
- Updated base to 17.33.42

## 2022-08-27
- Added `client-spoof` patch
