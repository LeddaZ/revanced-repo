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

# Generate SHA-256 hashes
if [ "$revanced" = 'yes' ]; then
    sha256sum build/revanced-nonroot*-signed.apk > build/SHA-256-yt.txt
fi

if [ "$music" = 'yes' ]; then
    sha256sum build/revanced-music-nonroot-*-signed.apk > build/SHA-256-ytm.txt
fi
