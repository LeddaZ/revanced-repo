# ReVanced Repo ![downloadCount](https://img.shields.io/github/downloads/LeddaZ/revanced-repo/total?color=blue&label=Downloads)
This repo template will allow you to build non-root ReVanced, ReVanced Music and X using GitHub Actions. This will help people who don't want to setup build environments on their machines.

This will build non-root ReVanced and ReVanced Music with all patches that are included by default. X will be built with all patches except `Hide recommended users` and `Hide view count`.

You can modify the `scripts/build.sh` script to choose the patches you want. A list of available patches and their descriptions can be found [here](https://revanced.app/patches).

### Latest supported versions
- YouTube: `19.16.39`
- YouTube Music: `7.02.52`
- X: `10.43.0-release.0`

## How to setup
1. Fork or create a new repository using this repository as a template ([Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)). DO NOT FORK if you need to set the new repo to private.
2. [Set up signing](signing.md) (if you don't want to, you can remove the signing part in the three workflows)
3. Download the needed APKs from APKMirror and upload them to a new release with the `base` tag ([Step 1](images/release_1.png), [Step 2](images/release_2.png)). The names must be `youtube.apk`, `music-arm.apk`, `music-arm64.apk`, `music-x86.apk`, `music-x86_64.apk`, `x.apk`.

## How to build
1. Go to Actions -> All workflows -> Choose what you want to build ([Example](images/workflow_run.png))
2. Run the workflow
3. Download the APKs from the latest release ([Example](images/build_release.png))
