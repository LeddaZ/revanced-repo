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

artifacts["revanced-integrations.apk"]="revanced/revanced-integrations revanced-integrations .apk"
artifacts["revanced-cli.jar"]="revanced/revanced-cli revanced-cli .jar"
artifacts["revanced-patches.jar"]="revanced/revanced-patches revanced-patches .jar"
artifacts["apkeep"]="EFForg/apkeep apkeep-x86_64-unknown-linux-gnu"

get_artifact_download_url() {
    # Usage: get_download_url <repo_name> <artifact_name> <file_type>
    local api_url result
    api_url="https://api.github.com/repos/$1/releases/latest"
    result=$(curl -s $api_url | jq ".assets[] | select(.name | contains(\"$2\") and contains(\"$3\") and (contains(\".sig\") | not)) | .browser_download_url")
    echo "${result:1:-1}"
}

# Fetch all the dependencies
for artifact in "${!artifacts[@]}"; do
    if [ ! -f "$artifact" ]; then
        echo "Downloading $artifact"
        curl -sLo "$artifact" $(get_artifact_download_url ${artifacts[$artifact]})
    fi
done

# Fetch Vanced microG
VMG_VERSION="0.2.24.220220"
chmod +x apkeep

if [ "$revanced" = 'yes' ]; then
    if [ ! -f "vanced-microG.apk" ]; then
        echo "Downloading Vanced microG"
        ./apkeep -a com.mgoogle.android.gms@$VMG_VERSION .
        mv com.mgoogle.android.gms@$VMG_VERSION.apk vanced-microG.apk
    fi
fi

mkdir -p build

if [ "$revanced" = 'yes' ]; then
    echo "************************************"
    echo "*    Building YouTube ReVanced     *"
    echo "************************************"

    if [ -f "youtube.apk" ]; then
        java -jar revanced-cli.jar patch -m revanced-integrations.apk \
            -b revanced-patches.jar --exclude "Premium heading" \
            -o build/revanced-nonroot.apk youtube.apk
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
        java -jar revanced-cli.jar patch -m revanced-integrations.apk \
            -b revanced-patches.jar -o build/revanced-music-nonroot-armeabi-v7a.apk music-arm.apk
        echo "ReVanced Music arm build finished"
    else
        echo "Cannot find YouTube Music arm APK, skipping build"
    fi

    echo "=== Building arm64 APK === "
    if [ -f "music-arm64.apk" ]; then
        java -jar revanced-cli.jar patch -m revanced-integrations.apk \
            -b revanced-patches.jar -o build/revanced-music-nonroot-arm64-v8a.apk music-arm64.apk
        echo "ReVanced Music arm64 build finished"
    else
        echo "Cannot find YouTube Music arm64 APK, skipping build"
    fi

    echo "=== Building x86 APK ==="
    if [ -f "music-x86.apk" ]; then
        java -jar revanced-cli.jar patch -m revanced-integrations.apk \
            -b revanced-patches.jar -o build/revanced-music-nonroot-x86.apk music-x86.apk
        echo "ReVanced Music x86 build finished"
    else
        echo "Cannot find YouTube Music x86 APK, skipping build"
    fi

    echo "=== Building x86_64 APK ==="
    if [ -f "music-x86_64.apk" ]; then
        java -jar revanced-cli.jar patch -m revanced-integrations.apk \
            -b revanced-patches.jar -o build/revanced-music-nonroot-x86_64.apk music-x86_64.apk
        echo "ReVanced Music x86_64 build finished"
    else
        echo "Cannot find YouTube Music x86_64 APK, skipping build"
    fi
    echo "ReVanced Music build finished"
else
    echo "Skipping ReVanced Music build"
fi
