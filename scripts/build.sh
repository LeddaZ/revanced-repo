#!/bin/bash

# Set up flags
music=no
revanced=no
while getopts mr flag; do
    case "${flag}" in
    m) music=yes ;;
    r) revanced=yes ;;
    esac
done

# Artifacts associative array aka dictionary
declare -A artifacts

artifacts["revanced-cli.jar"]="revanced/revanced-cli revanced-cli .jar"
artifacts["revanced-integrations.apk"]="revanced/revanced-integrations revanced-integrations .apk"
artifacts["revanced-patches.jar"]="revanced/revanced-patches revanced-patches .jar"
artifacts["vanced-microG.apk"]="inotia00/mMicroG microg.apk"

get_artifact_download_url() {
    # Usage: get_download_url <repo_name> <artifact_name> <file_type>
    local api_url="https://api.github.com/repos/$1/releases/latest"
    local result=$(curl $api_url | jq ".assets[] | select(.name | contains(\"$2\") and contains(\"$3\") and (contains(\".sig\") | not)) | .browser_download_url")
    echo ${result:1:-1}
}

# Fetch all the dependencies
for artifact in "${!artifacts[@]}"; do
    if [ ! -f $artifact ]; then
        echo "Downloading $artifact"
        curl -L -o $artifact $(get_artifact_download_url ${artifacts[$artifact]})
    fi
done

mkdir -p build

# A list of available patches and their descriptions can be found here:
# https://github.com/revanced/revanced-patches
if [ "$revanced" = 'yes' ]; then
    echo "************************************"
    echo "*    Building YouTube ReVanced     *"
    echo "************************************"

    yt_excluded_patches="-e premium-heading"

    if [ -f "youtube.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
            $yt_excluded_patches \
            -a youtube.apk -o build/revanced-nonroot.apk
        echo "YouTube ReVanced build finished"
    else
        echo "Cannot find YouTube APK, skipping build"
    fi
else
    echo "Skipping YouTube Revanced build"
fi

if [ "$music" = 'yes' ]; then
    echo "************************************"
    echo "*     Building ReVanced Music      *"
    echo "************************************"

    echo "=== Building arm APK ==="
    if [ -f "music-arm.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
            -a music-arm.apk -o build/revanced-music-nonroot-arm.apk
        echo "ReVanced Music arm build finished"
    else
        echo "Cannot find YouTube Music arm APK, skipping build"
    fi

    echo "=== Building arm64 APK === "
    if [ -f "music-arm64.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
            -a music-arm64.apk -o build/revanced-music-nonroot-arm64.apk
        echo "ReVanced Music arm64 build finished"
    else
        echo "Cannot find YouTube Music arm64 APK, skipping build"
    fi

    echo "=== Building x86 APK ==="
    if [ -f "music-x86.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
            -a music-x86.apk -o build/revanced-music-nonroot-x86.apk
        echo "ReVanced Music x86 build finished"
    else
        echo "Cannot find YouTube Music x86 APK, skipping build"
    fi

    echo "=== Building x86_64 APK ==="
    if [ -f "music-x86_64.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
            -a music-x86_64.apk -o build/revanced-music-nonroot-x86_64.apk
        echo "ReVanced Music x86_64 build finished"
        echo "ReVanced Music build finished"
    else
        echo "Cannot find YouTube Music x86_64 APK, skipping build"
    fi
else
    echo "Skipping ReVanced Music build"
fi
