# ReVanced Repo
This repo template will allow you to build non-root ReVanced using GitHub Actions. This will help people who don't want to setup build environments on their machines.
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
- seekbar-tapping
- video-ads

You can modify the `build_revanced.sh` script to choose the patches you want.

## How to setup
1. Fork or create a new repository using this repository as a template ([Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)). DO NOT FORK if you need to set the new repo to private.
2. Download latest (compatible) APK of YouTube from APKMirror.com: [17.26.35](https://www.apkmirror.com/apk/google-inc/youtube/youtube-17-26-35-release/)
     - Rename to `com.google.android.youtube.apk`
3. Publish a new release under tag `base` and upload the APK to the release. ([Step 1](images/release_1.png), [Step 2](images/release_2.png))
4. [Set up signing](signing.md) (if you don't want to, you can remove the signing part in `.github/workflows/main.yml`)

## How to build
1. Go to Actions -> All workflows -> ReVanced Build ([Example](images/workflow_run.png))
2. Run the workflow
3. Download the APKs from the release with the tag corresponding to the YouTube version ([Example](images/build_release.png))
