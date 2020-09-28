#!/bin/bash
set -e

OUTPUT=$1
MODULE_VERSION="6.0.0"
SWIFT_VERSION="5.3"
AUTHOR="Alexis Aubry-Akers"
AUTHOR_URL="https://alexisonline.dev"
MODULE_NAME="HTMLString"
COPYRIGHT="Copyright © 2016 - present $AUTHOR. Available under the MIT License."
GITHUB_URL="https://github.com/alexaubry/HTMLString"
GH_PAGES_URL="https://alexaubry.github.io/HTMLString"

bundle exec jazzy \
    --swift-version $SWIFT_VERSION \
    -a "$AUTHOR" \
    -u "$AUTHOR_URL" \
    -m "$MODULE_NAME" \
    --module-version "$MODULE_VERSION" \
    --copyright "$COPYRIGHT" \
    -g "$GITHUB_URL" \
    -d "dash-feed://$GH_PAGES_URL/$MODULE_NAME/docsets/$MODULE_NAME.xml"
    --github-file-prefix "$GITHUB_URL/tree/main" \
    -r "$GH_PAGES_URL" \
    -o "$OUTPUT"\
    --min-acl public \
    --use-safe-filenames
