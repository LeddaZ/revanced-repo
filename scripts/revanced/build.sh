#!/bin/bash

# Latest compatible versions of APKs:
# YouTube 17.32.35
# Vanced microG 0.2.24.220220

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
    mv com.mgoogle.android.gms@$VMG_VERSION.apk ../../vanced-microG.apk
fi

mkdir -p ../../build

# A list of available patches and their descriptions can be found here:
# https://github.com/LeddaZ/revanced-patches

non_yt_ytm_patches="-e general-reddit-ads -e pflotsh-ecmwf-subscription-unlock -e promo-code-unlock -e tiktok-ads -e timeline-ads"

echo "************************************"
echo "*    Building YouTube ReVanced     *"
echo "************************************"

yt_excluded_patches="-e background-play -e codecs-unlock -e compact-header -e custom-music-branding -e exclusive-audio-playback -e hide-get-premium -e minimized-playback-music -e music-microg-support -e music-video-ads -e premium-heading -e tasteBuilder-remover -e upgrade-button-remover"
yt_included_patches="-i enable-debugging"

if [ -f "youtube.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $yt_excluded_patches $yt_included_patches $non_yt_ytm_patches \
                               -a youtube.apk -o ../../build/revanced-nonroot.apk
else
    echo "Cannot find YouTube APK, skipping build"
fi
