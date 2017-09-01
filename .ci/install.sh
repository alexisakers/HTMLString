#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    gem install xcpretty
fi

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "4.0-DEVELOPMENT-SNAPSHOT-2017-08-31-a" >> .swift-version
fi
