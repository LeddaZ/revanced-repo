#!/bin/bash

music=no
revanced=no
x=no
while getopts mrx flag; do
    case "${flag}" in
    m) music=yes ;;
    r) revanced=yes ;;
    x) x=yes ;;
    esac
done

mkdir -p build/hashes

# Generate SHA-256 hashes
if [ "$revanced" = 'yes' ]; then
    sha256sum build/yt/yt-signed.apk >build/hashes/sha256-yt.txt
fi

if [ "$music" = 'yes' ]; then
    sha256sum build/ytm/ytm*-signed.apk >build/hashes/sha256-ytm.txt
fi

if [ "$x" = 'yes' ]; then
    sha256sum build/x/x-signed.apk >build/hashes/sha256-x.txt
fi
