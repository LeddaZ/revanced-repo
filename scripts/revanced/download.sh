#!/bin/bash

YT_VERSION="17-32-35"

declare -A apks

apks["youtube.apk"]=dl_yt

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
	echo "Downloading YouTube..."

	local base_apk="youtube.apk"
	if [ ! -f "$base_apk" ]; then
		declare -r dl_url=$(dl_apk "https://www.apkmirror.com/apk/google-inc/youtube/youtube-${YT_VERSION}-release/" \
			"APK</span>[^@]*@\([^#]*\)" \
			"$base_apk")
	fi
}

## Main

for apk in "${!apks[@]}"; do
    if [ ! -f $apk ]; then
        ${apks[$apk]}
    fi
done
