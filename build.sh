#!/bin/bash

set -e

# Check if Frameworks folder exists and remove any existing XCFrameworks
if [ Frameworks ]; then
    rm -rf Frameworks
fi

# Create Frameworks folder to store XCFrameworks in
mkdir Frameworks

# List packages that are to be converted to XCFrameworks
for PACKAGE in "jLocation" "jNetworking"; do

# Build the scheme for all platforms that we plan to support
for PLATFORM in "iOS" "iOS Simulator"; do

    case $PLATFORM in
        "iOS") RELEASE_FOLDER="Release-iphoneos" ;;
        "iOS Simulator") RELEASE_FOLDER="Release-iphonesimulator" ;;
    esac

    ARCHIVE_PATH=$RELEASE_FOLDER

    xcodebuild archive -workspace . -scheme $PACKAGE \
        -destination "generic/platform=$PLATFORM" \
        -archivePath $ARCHIVE_PATH \
        -derivedDataPath ".build" \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES

    FRAMEWORK_PATH="$ARCHIVE_PATH.xcarchive/Products/usr/local/lib/$PACKAGE.framework"

    MODULES_PATH="$FRAMEWORK_PATH/Modules"

    mkdir -p $MODULES_PATH

    BUILD_PRODUCTS_PATH=".build/Build/Intermediates.noindex/ArchiveIntermediates/$PACKAGE/BuildProductsPath"

    RELEASE_PATH="$BUILD_PRODUCTS_PATH/$RELEASE_FOLDER"

    SWIFT_MODULE_PATH="$RELEASE_PATH/$PACKAGE.swiftmodule"

    RESOURCES_BUNDLE_PATH="$RELEASE_PATH/${PACKAGE}_${PACKAGE}.bundle"

    if [ -d $SWIFT_MODULE_PATH ]; then
        cp -r $SWIFT_MODULE_PATH $MODULES_PATH
    else
        echo "module $PACKAGE { export * }" > $MODULES_PATH/module.modulemap
    fi

    # Copy resources bundle, if exists
    if [ -e $RESOURCES_BUNDLE_PATH ]; then
        cp -r $RESOURCES_BUNDLE_PATH $FRAMEWORK_PATH
    fi

done

xcodebuild -create-xcframework \
    -framework Release-iphoneos.xcarchive/Products/usr/local/lib/$PACKAGE.framework \
    -framework Release-iphonesimulator.xcarchive/Products/usr/local/lib/$PACKAGE.framework \
    -output ./Frameworks/$PACKAGE.xcframework

rm -rf Release-iphoneos.xcarchive
rm -rf Release-iphonesimulator.xcarchive

done

