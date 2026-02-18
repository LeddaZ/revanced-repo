# ReVanced Repo ![downloadCount](https://img.shields.io/github/downloads/LeddaZ/revanced-repo/total?color=blue&label=Downloads)
This repo template will allow you to build non-root ReVanced, ReVanced Music and X using GitHub Actions. This will help people who don't want to setup build environments on their machines.

> [!warning]
> These are **unofficial** builds. The ReVanced team is not responsible for issues derived from unofficial apps and I'm not part of the ReVanced team.

> [!warning]
> X is currently **unspported**. The app added checks that prevent logging in on modified versions; while there are workarounds, they don't work for everyone and might stop working at any time, so until a stable/permanent solution is found, I won't build patched X APKs.

You can modify the `scripts/build.sh` script to choose the patches you want. A list of available patches and their descriptions can be found [here](https://revanced.app/patches).

### Supported versions
- YouTube: `20.14.43`
- YouTube Music: `8.10.52`

## How to setup
1. Fork or create a new repository using this repository as a template ([Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)). DO NOT FORK if you need to set the new repo to private.
2. [Set up signing](signing.md) (if you don't want to, you can remove the signing part in the workflows)
3. Download the needed APKs from APKMirror and upload them to a new release with the `base` tag ([Step 1](images/release_1.png), [Step 2](images/release_2.png)). The names must be `yt.apk`, `music-arm.apk`, `music-arm64.apk`, `music-x86.apk`, `music-x86_64.apk`.

## How to build
1. Go to Actions -> All workflows -> Choose what you want to build ([Example](images/workflow_run.png))
2. Run the workflow
3. Download the APKs from the latest release ([Example](images/build_release.png))
