#!/bin/bash

music=no
revanced=no
while getopts mr flag
do
    case "${flag}" in
        m) music=yes;;
        r) revanced=yes;;
    esac
done

YT_VERSION="17-49-37"
YTM_VERSION="5-36-51"

declare -A apks

apks["youtube.apk"]=dl_yt
apks["music-arm.apk"]=dl_ytm_arm
apks["music-arm64.apk"]=dl_ytm_arm64
apks["music-x86.apk"]=dl_ytm_x86
apks["music-x86_64.apk"]=dl_ytm_x86_64

## Functions

# Wget user agent
WGET_HEADER="User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"

# Wget function
req() { wget -nv -O "$2" --header="$WGET_HEADER" "$1"; }

# Wget download apk
dl_apk() {
	local url=$1 regexp=$2 output=$3
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n "s/href=\"/@/g; s;.*${regexp}.*;\1;p")"
	echo "$url"
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n 's;.*href="\(.*key=[^"]*\)">.*;\1;p')"
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n 's;.*href="\(.*key=[^"]*\)">.*;\1;p')"
	req "$url" "$output"
}

# Download YouTube
dl_yt() {
	if [ "$revanced" = 'yes' ]; then
		echo "Downloading YouTube..."

		local base_apk="youtube.apk"
		if [ ! -f "$base_apk" ]; then
			declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube/youtube-${YT_VERSION}-release/" \
				"APK</span>[^@]*@\([^#]*\)" \
				"$base_apk")
		fi
	else
		echo "Skipping YouTube..."
	fi
}

# Download YouTube Music
dl_ytm_arm() {
	if [ "$music" = 'yes' ]; then
		echo "Downloading YouTube Music arm..."

		local base_apk="music-arm.apk"
		if [ ! -f "$base_apk" ]; then
			local regexp_arch='armeabi-v7a</div>[^@]*@\([^"]*\)'
			declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
				"$regexp_arch" \
				"$base_apk")
		fi
	else
		echo "Skipping YouTube Music arm..."
	fi
}

dl_ytm_arm64() {
	if [ "$music" = 'yes' ]; then
		echo "Downloading YouTube Music arm64..."

		local base_apk="music-arm64.apk"
		if [ ! -f "$base_apk" ]; then
			local regexp_arch='arm64-v8a</div>[^@]*@\([^"]*\)'
			declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
				"$regexp_arch" \
				"$base_apk")
		fi
	else
		echo "Skipping YouTube Music arm64..."
	fi
}

dl_ytm_x86() {
	if [ "$music" = 'yes' ]; then
		echo "Downloading YouTube Music x86..."

		local base_apk="music-x86.apk"
		if [ ! -f "$base_apk" ]; then
			local regexp_arch='x86</div>[^@]*@\([^"]*\)'
			declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
				"$regexp_arch" \
				"$base_apk")
		fi
	else
		echo "Skipping YouTube Music x86..."
	fi
}

dl_ytm_x86_64() {
	if [ "$music" = 'yes' ]; then
		echo "Downloading YouTube Music x86_64..."

		local base_apk="music-x86_64.apk"
		if [ ! -f "$base_apk" ]; then
			local regexp_arch='x86_64</div>[^@]*@\([^"]*\)'
			declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
				"$regexp_arch" \
				"$base_apk")
		fi
	else
		echo "Skipping YouTube Music x86_64..."
	fi
}

## Main

for apk in "${!apks[@]}"; do
    if [ ! -f $apk ]; then
        ${apks[$apk]}
    fi
done
