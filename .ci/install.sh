#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "👉  Installing build dependencies"
    gem install xcpretty
fi

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    
    echo "👉  Installing Swift"
    SWIFT_URL=https://swift.org/builds/$LOCAL_SWIFT_BRANCH/ubuntu1404/$LOCAL_SWIFT_VERSION/$LOCAL_SWIFT_VERSION-ubuntu14.04.tar.gz
    curl -L $SWIFT_URL -o swift.tar.gz
    sudo tar -xzf swift.tar.gz --directory /usr/local --strip-components=2

    echo "👉  Fixing CoreFoundation"
    sudo find /usr/local/lib/swift/CoreFoundation -type f -exec chmod 644 {} \;

fi
