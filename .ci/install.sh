#!/bin/bash
set -e
OS_NAME=$1

if [[ $OS_NAME == 'Darwin' ]]; then
    echo "👉  Installing build dependencies"
    sudo xcode-select -switch /Applications/Xcode_10.2.app
    bundle install
fi

if [[ $OS_NAME == 'Linux' ]]; then
    
    echo "👉  Installing Swift"
    SWIFT_URL=https://swift.org/builds/swift-5.0.1-release/ubuntu1604/swift-5.0.1-RELEASE/swift-5.0.1-RELEASE-ubuntu16.04.tar.gz
    curl -L $SWIFT_URL -o swift.tar.gz
    sudo tar -xzf swift.tar.gz --directory /usr/local --strip-components=2

    echo "👉  Fixing CoreFoundation"
    sudo find /usr/local/lib/swift/CoreFoundation -type f -exec chmod 644 {} \;

fi
