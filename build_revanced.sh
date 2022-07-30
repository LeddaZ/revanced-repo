#!/bin/bash

# Latest compatible versions of APKs
# YouTube 17.26.35
# YouTube Music 5.16.51
# Vanced microG 0.2.24.220220

YT_VERSION="17.26.35"
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

# Fetch microG
chmod +x apkeep

if [ ! -f "vanced-microG.apk" ]; then
    echo "Downloading Vanced microG"
    ./apkeep -a com.mgoogle.android.gms@$VMG_VERSION .
    mv com.mgoogle.android.gms@$VMG_VERSION.apk vanced-microG.apk
fi

mkdir -p build

# A list of available patches and their descriptions can be found here:
# https://github.com/LeddaZ/revanced-patches

non_yt_ytm_patches="-e general-reddit-ads -e timeline-ads"

echo "************************************"
echo "*    Building YouTube ReVanced     *"
echo "************************************"

yt_excluded_patches="-e always-autorepeat -e autorepeat-by-default -e background-play -e codecs-unlock -e compact-header -e disable-create-button -e disable-fullscreen-panels -e enable-debugging -e enable-wide-searchbar -e exclusive-audio-playback -e force-vp9-codec -e hide-cast-button -e hide-get-premium -e hide-infocard-suggestions -e hide-shorts-button -e minimized-playback-music -e music-microg-support -e music-video-ads -e premium-heading -e sponsorblock -e tasteBuilder-remover -e upgrade-button-remover"
yt_included_patches="-i hdr-auto-brightness -i swipe-controls"

if [ -f "youtube.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $yt_excluded_patches $yt_included_patches $non_yt_ytm_patches \
                               -a youtube.apk -o build/revanced-nonroot.apk
else
    echo "Cannot find YouTube APK, skipping build"
fi

echo "************************************"
echo "*     Building ReVanced Music      *"
echo "************************************"

ytm_excluded_patches="-e always-autorepeat -e amoled -e autorepeat-by-default -e compact-header -e custom-branding -e custom-playback-speed -e disable-create-button -e disable-fullscreen-panels -e enable-debugging -e enable-wide-searchbar -e force-vp9-codec -e general-ads -e hdr-auto-brightness -e hide-autoplay-button -e hide-cast-button -e hide-infocard-suggestions -e hide-shorts-button -e hide-watermark -e microg-support -e minimized-playback -e old-quality-layout -e premium-heading -e remember-video-quality -e return-youtube-dislike -e seekbar-tapping -e sponsorblock -e swipe-controls -e video-ads"

echo "Building arm architecture..."
if [ -f "music-arm.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $ytm_excluded_patches $non_yt_ytm_patches \
                               -a music-arm.apk -o build/revanced-music-nonroot-arm.apk
else
    echo "Cannot find YouTube Music arm APK, skipping build"
fi

echo "Building arm64 architecture..."
if [ -f "music-arm64.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $ytm_excluded_patches $non_yt_ytm_patches \
                               -a music-arm64.apk -o build/revanced-music-nonroot-arm64.apk
else
    echo "Cannot find YouTube Music arm64 APK, skipping build"
fi

echo "Building x86 architecture..."
if [ -f "music-x86.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $ytm_excluded_patches $non_yt_ytm_patches \
                               -a music-x86.apk -o build/revanced-music-nonroot-x86.apk
else
    echo "Cannot find YouTube Music x86 APK, skipping build"
fi

echo "Building x86_64 architecture..."
if [ -f "music-x86_64.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $ytm_excluded_patches $non_yt_ytm_patches \
                               -a music-x86_64.apk -o build/revanced-music-nonroot-x86_64.apk
else
    echo "Cannot find YouTube Music x86_64 APK, skipping build"
fi
