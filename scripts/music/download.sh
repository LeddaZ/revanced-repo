#!/bin/bash

YTM_VERSION="5-17-51"

declare -A apks

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

# Download YouTube Music
dl_ytm_arm() {
	echo "Downloading YouTube Music arm..."

	local base_apk="music-arm.apk"
	if [ ! -f "$base_apk" ]; then
		local regexp_arch='armeabi-v7a</div>[^@]*@\([^"]*\)'
		declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
			"$regexp_arch" \
			"$base_apk")
	fi
}

dl_ytm_arm64() {
	echo "Downloading YouTube Music arm64..."

	local base_apk="music-arm64.apk"
	if [ ! -f "$base_apk" ]; then
		local regexp_arch='arm64-v8a</div>[^@]*@\([^"]*\)'
		declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
			"$regexp_arch" \
			"$base_apk")
	fi
}

dl_ytm_x86() {
	echo "Downloading YouTube Music x86..."

	local base_apk="music-x86.apk"
	if [ ! -f "$base_apk" ]; then
		local regexp_arch='x86</div>[^@]*@\([^"]*\)'
		declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
			"$regexp_arch" \
			"$base_apk")
	fi
}

dl_ytm_x86_64() {
	echo "Downloading YouTube Music x86_64..."

	local base_apk="music-x86_64.apk"
	if [ ! -f "$base_apk" ]; then
		local regexp_arch='x86_64</div>[^@]*@\([^"]*\)'
		declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-${YTM_VERSION}-release/" \
			"$regexp_arch" \
			"$base_apk")
	fi
}

## Main

for apk in "${!apks[@]}"; do
    if [ ! -f $apk ]; then
        ${apks[$apk]}
    fi
done
