#!/bin/bash

# Set up flags
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

for file in *cli*; do
    mv -- "$file" revanced-cli.jar
done

for file in *patches*; do
    mv -- "$file" revanced-patches.rvp
done

mkdir -p build/yt
mkdir -p build/ytm
mkdir -p build/x

if [ "$revanced" = 'yes' ]; then
    echo "**************************"
    echo "*    Building YouTube    *"
    echo "**************************"

    if [ -f "yt.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            -o build/yt/yt.apk yt.apk
        echo "YouTube ReVanced build finished"
    else
        echo "Cannot find YouTube APK, skipping build"
    fi
else
    echo "Skipping YouTube ReVanced build"
fi

if [ "$music" = 'yes' ]; then
    echo "********************************"
    echo "*    Building YouTube Music    *"
    echo "********************************"

    echo "=== Building arm APK ==="
    if [ -f "music-arm.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            -o build/ytm/ytm-armeabi-v7a.apk music-arm.apk
        echo "ReVanced Music arm build finished"
    else
        echo "Cannot find YouTube Music arm APK, skipping build"
    fi

    echo "=== Building arm64 APK === "
    if [ -f "music-arm64.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            -o build/ytm/ytm-arm64-v8a.apk music-arm64.apk
        echo "ReVanced Music arm64 build finished"
    else
        echo "Cannot find YouTube Music arm64 APK, skipping build"
    fi

    echo "=== Building x86 APK ==="
    if [ -f "music-x86.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            -o build/ytm/ytm-x86.apk music-x86.apk
        echo "ReVanced Music x86 build finished"
    else
        echo "Cannot find YouTube Music x86 APK, skipping build"
    fi

    echo "=== Building x86_64 APK ==="
    if [ -f "music-x86_64.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            -o build/ytm/ytm-x86_64.apk music-x86_64.apk
        echo "ReVanced Music x86_64 build finished"
    else
        echo "Cannot find YouTube Music x86_64 APK, skipping build"
    fi
    echo "ReVanced Music build finished"
else
    echo "Skipping ReVanced Music build"
fi

if [ "$x" = 'yes' ]; then
    echo "********************"
    echo "*    Building X    *"
    echo "********************"

    if [ -f "x.apk" ]; then
        java -jar revanced-cli.jar patch -p revanced-patches.rvp \
            --di 136 --di 139 -o build/x/x.apk x.apk
        echo "X build finished"
    else
        echo "Cannot find X APK, skipping build"
    fi
else
    echo "Skipping X build"
fi
