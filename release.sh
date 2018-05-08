#!/bin/bash

declare -a SWIFT_VERSIONS=(
    "org.swift.4020170919"
    "org.swift.40220171101a"
    "org.swift.40320171205a"
    "org.swift.4120180329a"
)

rm -rf .build
mkdir .build

carthage build --no-skip-current --toolchain "org.swift.40320171205a"

for version in "${SWIFT_VERSIONS[@]}"
do
#carthage build --no-skip-current --toolchain "$version"
    mkdir .build/"$version"
done
