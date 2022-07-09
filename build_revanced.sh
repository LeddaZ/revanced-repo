#!/bin/bash

# Latest compatible versions of APKs
# YouTube 17.25.34
# Vanced microG 0.2.24.220220

YT_VERSION="17.25.34"
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

echo "************************************"
echo "*    Building YouTube ReVanced     *"
echo "************************************"

mkdir -p build

# List of available patches and their descriptions
# From revanced-patches 2.12.0 (LeddaZ's fork)

# seekbar-tapping: Enable tapping on the seekbar of the YouTube player. 
# general-ads: Remove general ads in bytecode. 
# video-ads: Remove ads in the YouTube video player. 
# hide-infocard-suggestions: Hides infocards in videos. 
# custom-branding: Change the branding of YouTube. 
# premium-heading: Show the premium branding on the the YouTube home screen. 
# minimized-playback: Enable minimized and background playback. 
# disable-fullscreen-panels: Disable comments panel in fullscreen view. 
# old-quality-layout: Enable the original quality flyout menu. 
# hide-autoplay-button: Disable the autoplay button. 
# disable-create-button: Disable the create button. 
# amoled: Enables pure black theme. 
# hide-shorts-button: Hide the shorts button. 
# hide-cast-button: Hide the cast button. 
# hide-watermark: Hide the creator's watermark on video's. 
# microg-support: Allow YouTube ReVanced to run without root and under a different package name. 
# custom-playback-speed: Allows to change the default playback speed options. 
# hdr-max-brightness: Set brightness to max for HDR videos in fullscreen mode. 
# enable-debugging: Enable app debugging by patching the manifest file 
# background-play: Enable playing music in the background. 
# exclusive-audio-playback: Add the option to play music without video. 
# codecs-unlock: Enables more audio codecs. Usually results in better audio quality but may depend on song and device. 
# upgrade-button-remover: Remove the upgrade tab from the pivot bar in YouTube music. 
# tasteBuilder-remover: Removes the "Tell us which artists you like" card from the Home screen. The same functionality can be triggered from the settings anyway.
# swipe-controls: Volume and brightness swipe controls
# wide-searchbar: Replaces the search-icon with a wide searchbar. This will hide the youtube logo when this is active.
# autorepeat-by-default: Enables auto repeating of videos by default.

excluded_patches="-e background-play -e exclusive-audio-playback -e codecs-unlock -e upgrade-button-remover -e disable-create-button -e premium-heading -e hide-shorts-button -e disable-fullscreen-panels -e tasteBuilder-remover -e hide-cast-button -e hdr-max-brightness -e hide-infocard-suggestions -e enable-debugging -e wide-searchbar -e autorepeat-by-default -e swipe-controls"

if [ -f "com.google.android.youtube.apk" ]
then
    java -jar revanced-cli.jar -m revanced-integrations.apk -b revanced-patches.jar \
                               $excluded_patches \
                               -a com.google.android.youtube.apk -o build/revanced-nonroot.apk
else
    echo "Cannot find YouTube APK, skipping build"
fi
