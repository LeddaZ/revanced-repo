# ReVanced Repo
This repo template will allow you to build non-root ReVanced and ReVanced Music using GitHub Actions. This will help people who don't want to setup build environments on their machines.
By default this will build non-root ReVanced with these patches:

- amoled
- custom-branding
- custom-playback-speed
- general-ads
- hide-autoplay-button
- hide-watermark
- microg-support
- minimized-playback
- old-quality-layout
- remember-video-quality
- return-youtube-dislike
- seekbar-tapping
- swipe-controls
- video-ads

ReVanced Music will be built with these patches:

- background-play
- codecs-unlock
- custom-music-branding
- exclusive-audio-playback
- hide-get-premium
- minimized-playback-music
- music-microg-support
- music-video-ads
- tasteBuilder-remover
- upgrade-button-remover

You can modify the `build_revanced.sh` script to choose the patches you want. A list of available patches and their descriptions can be found [here](https://github.com/LeddaZ/revanced-patches).

## How to setup
1. Fork or create a new repository using this repository as a template ([Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)). DO NOT FORK if you need to set the new repo to private.
2. Download latest (compatible) APKs from APKMirror.com:
     - [YouTube 17.29.34](https://www.apkmirror.com/apk/google-inc/youtube/youtube-17-29-34-release/), rename to `youtube.apk`
     - [YouTube Music 5.16.51](https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-5-16-51-release/), rename to `music.apk`; APKs published here are arm64 only, since YTM doesn't have a single APK for all architectures
3. Publish a new release under tag `base` and upload the APKs to the release. ([Step 1](images/release_1.png), [Step 2](images/release_2.png))
4. [Set up signing](signing.md) (if you don't want to, you can remove the signing part in `.github/workflows/main.yml`)

## How to build
1. Go to Actions -> All workflows -> ReVanced Build ([Example](images/workflow_run.png))
2. Run the workflow
3. Download the APKs from the latest release ([Example](images/build_release.png))
