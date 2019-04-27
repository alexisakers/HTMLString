#!/bin/bash
set -e
OS_NAME=$1

if [[ $OS_NAME == 'Darwin' ]]; then

    echo "🛠 Building project in Debug mode"
    xcodebuild clean build -project HTMLString.xcodeproj -scheme "$SCHEME" -configuration Debug | xcpretty

    echo "🛠 Building project in Release mode"
    xcodebuild clean build -project HTMLString.xcodeproj -scheme "$SCHEME" -configuration Release | xcpretty
    
    case $TEST in

    'simulator')
        echo "📲 Creating Simulator"
        DEVICE_ID=$(xcrun simctl create $TEST_DEVICE \
                    com.apple.CoreSimulator.SimDeviceType.$TEST_DEVICE \
                    com.apple.CoreSimulator.SimRuntime.$TEST_RUNTIME)

        echo "🔍 Running unit tests on simulator [$DEVICE_ID]"
        xcrun simctl boot $DEVICE_ID
        xcodebuild clean test -project HTMLString.xcodeproj -scheme "$SCHEME" -destination "id=$DEVICE_ID" | xcpretty
        ;;

    'device')
        echo "🔍 Running unit tests on device"
        xcodebuild clean test -project HTMLString.xcodeproj -scheme "$SCHEME" -destination "$DESTINATION" | xcpretty
        ;;

    *)
        echo "⏺ No unit tests to run."
        ;;

    esac
    
fi

if [[ $OS_NAME == 'Linux' ]]; then

    echo "🛠 Building project in Debug mode"
    swift build
    
    echo "🛠 Building project in Release mode"
    swift build -c release

    echo "🔍 Running unit tests"
    swift test

fi
