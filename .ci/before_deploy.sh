#!/bin/bash
set -e

if [[ $DEPLOY == 'true' ]]; then
    carthage build --no-skip-current
    carthage archive $FRAMEWORK_NAME
fi
