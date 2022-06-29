#!/bin/bash

# Latest compatible versions of APKs
# YouTube 17.24.35
# Vanced microG 0.2.24.220220

YT_VERSION="17.24.35"
VMG_VERSION="0.2.24.220220"

# Artifacts associative array aka dictionary
declare -A artifacts

artifacts["revanced-cli.jar"]="revanced/revanced-cli revanced-cli .jar"
artifacts["revanced-integrations.apk"]="revanced/revanced-integrations app-release-unsigned .apk"
artifacts["revanced-patches.jar"]="revanced/revanced-patches revanced-patches .jar"
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

echo "************************************"
echo "*    Building YouTube ReVanced     *"
echo "************************************"

mkdir -p build
# Available patches: premium-heading, disable-fullscreen-panels, disable-create-button, disable-shorts-button,
# custom-playback-speed, seekbar-tapping, general-ads, video-ads, custom-branding, minimized-playback,
# old-quality-layout, amoled, hide-cast-button, hide-watermark, microg-support 
excluded_patches="-e background-play -e exclusive-audio-playback -e codecs-unlock -e upgrade-button-remover -e disable-create-button -e premium-heading -e disable-shorts-button -e disable-fullscreen-panels -e tasteBuilder-remover"

if [ -f "com.google.android.youtube.apk" ]
then                           -a com.google.android.youtube.apk -o build/revanced-root.apk
    echo "Building Non-root APK"
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $excluded_patches \
                               -a com.google.android.youtube.apk -o build/revanced-nonroot.apk
else
    echo "Cannot find YouTube APK, skipping build"
fi
