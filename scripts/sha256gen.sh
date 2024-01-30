#!/bin/bash

music=no
revanced=no
while getopts mr flag; do
    case "${flag}" in
    m) music=yes ;;
    r) revanced=yes ;;
    esac
done

mkdir -p build/hashes

# Generate SHA-256 hashes
if [ "$revanced" = 'yes' ]; then
    sha256sum build/yt/yt.apk >build/hashes/sha256-yt.txt
fi

if [ "$music" = 'yes' ]; then
    sha256sum build/ytm/ytm*.apk >build/hashes/sha256-ytm.txt
fi
