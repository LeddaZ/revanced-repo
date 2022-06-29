# ReVanced Repo
This repo template will allow you to build non-root ReVanced using Github Actions. This will help people who don't want to setup build environments on their machines.
By default this will build non-root ReVanced with all patches except the following:

- background-play
- exclusive-audio-playback
- codecs-unlock
- upgrade-button-remover
- disable-create-button
- premium-heading
- disable-shorts-button
- disable-fullscreen-panels
- tasteBuilder-remover

You can modify the `build_revanced.sh` script to choose the patches you want.

## How to setup
1. Fork or create a new repository using this repository as a template ([Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)). DO NOT FORK if you need to set the new repo to private.
2. Download latest (compatible) APK of YouTubec from APKMirror.com:
   - [YouTube 17.24.35](https://www.apkmirror.com/apk/google-inc/youtube/youtube-17-24-35-release/)
     - Rename to `com.google.android.youtube.apk`
3. Publish a new release under tag `base` and upload the APK to the release. ([Step 1](images/release_1.png), [Step 2](images/release_2.png))
4. [Set up signing](signing.md) (if you don't want to, you can remove the signing part in `.github/workflows/main.yml`)

## How to build
1. Go to Actions -> All workflows -> ReVanced Build ([Example](images/workflow_run.png))
2. Run the workflow
3. Download the APKs from the draft releases ([Example](images/build_release.png))
