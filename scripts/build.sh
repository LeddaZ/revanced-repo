#!/bin/bash

# Latest compatible versions of APKs:
# YouTube 17.36.37
# YouTube Music 5.25.51
# Vanced microG 0.2.24.220220

music=no
revanced=no
while getopts mr flag
do
    case "${flag}" in
        m) music=yes;;
        r) revanced=yes;;
    esac
done

VMG_VERSION="0.2.24.220220"

# Artifacts associative array aka dictionary
declare -A artifacts

artifacts["revanced-cli.jar"]="revanced/revanced-cli revanced-cli .jar"
artifacts["revanced-integrations.apk"]="revanced/revanced-integrations app-release-unsigned .apk"
artifacts["revanced-patches.jar"]="LeddaZ/revanced-patches revanced-patches .jar"
artifacts["apkeep"]="EFForg/apkeep apkeep-x86_64-unknown-linux-gnu"

get_artifact_download_url () {
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

# Fetch Vanced microG
chmod +x apkeep

if [ ! -f "vanced-microG.apk" ]; then
    echo "Downloading Vanced microG"
    ./apkeep -a com.mgoogle.android.gms@$VMG_VERSION .
    mv com.mgoogle.android.gms@$VMG_VERSION.apk vanced-microG.apk
fi

mkdir -p build

# A list of available patches and their descriptions can be found here:
# https://github.com/LeddaZ/revanced-patches

if [ "$revanced" = 'yes' ]; then
    echo "************************************"
    echo "*    Building YouTube ReVanced     *"
    echo "************************************"

    yt_excluded_patches="-e background-play -e codecs-unlock -e compact-header -e custom-music-branding -e exclusive-audio-playback -e hide-get-premium -e minimized-playback-music -e music-microg-support -e music-video-ads -e premium-heading -e tasteBuilder-remover -e upgrade-button-remover"
    yt_included_patches="-i enable-debugging"

    if [ -f "youtube.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                                $yt_excluded_patches $yt_included_patches \
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

    ytm_excluded_patches="-e always-autorepeat -e autorepeat-by-default -e client-spoof -e custom-branding -e custom-playback-speed -e custom-video-buffer -e disable-auto-captions -e disable-auto-player-popup-panels -e disable-create-button -e disable-fullscreen-panels -e downloads -e enable-debugging -e enable-wide-searchbar -e general-ads -e hdr-auto-brightness -e hide-autoplay-button -e hide-cast-button -e hide-email-address -e hide-infocard-suggestions -e hide-shorts-button -e hide-time-and-seekbar -e hide-watermark -e microg-support -e minimized-playback -e old-quality-layout -e premium-heading -e remember-video-quality -e return-youtube-dislike -e seekbar-tapping -e settings -e sponsorblock -e swipe-controls -e tablet-mini-player -e theme -e video-ads"

    echo "=== Building arm APK ==="
    if [ -f "music-arm.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                                $ytm_excluded_patches \
                                -a music-arm.apk -o build/revanced-music-nonroot-arm.apk
        echo "ReVanced Music arm build finished"
    else
        echo "Cannot find YouTube Music arm APK, skipping build"
    fi

    echo "=== Building arm64 APK === "
    if [ -f "music-arm64.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                                $ytm_excluded_patches \
                                -a music-arm64.apk -o build/revanced-music-nonroot-arm64.apk
        echo "ReVanced Music arm64 build finished"
    else
        echo "Cannot find YouTube Music arm64 APK, skipping build"
    fi

    echo "=== Building x86 APK ==="
    if [ -f "music-x86.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                                $ytm_excluded_patches \
                                -a music-x86.apk -o build/revanced-music-nonroot-x86.apk
        echo "ReVanced Music x86 build finished"
    else
        echo "Cannot find YouTube Music x86 APK, skipping build"
    fi

    echo "=== Building x86_64 APK ==="
    if [ -f "music-x86_64.apk" ]; then
        java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                                $ytm_excluded_patches \
                                -a music-x86_64.apk -o build/revanced-music-nonroot-x86_64.apk
        echo "ReVanced Music x86_64 build finished"
        echo "ReVanced Music build finished"
    else
        echo "Cannot find YouTube Music x86_64 APK, skipping build"
    fi
else
    echo "Skipping ReVanced Music build"
fi
