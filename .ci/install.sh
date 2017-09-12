#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    gem install xcpretty
fi

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    sudo apt-get install libstdc++6
    echo "4.0-DEVELOPMENT-SNAPSHOT-2017-08-31-a" >> .swift-version
    eval "$(curl -sL https://gist.githubusercontent.com/kylef/5c0475ff02b7c7671d2a/raw/9f442512a46d7a2af7b850d65a7e9bd31edfb09b/swiftenv-install.sh)"
    export SWIFT_VERSION="4.0-DEVELOPMENT-SNAPSHOT-2017-08-31-a"
fi
