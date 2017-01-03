MODULE=HTMLString
VERSION=2.1
SCHEME=HTMLString

bundle exec jazzy \
  --clean \
  --author Alexis Aubry Radanovic \
  --author_url https://github.com/alexaubry \
  --github_url https://github.com/alexaubry/$MODULE \
  --github-file-prefix https://github.com/alexaubry/$MODULE/tree/master \
  --module-version $VERSION \
  --xcodebuild-arguments -scheme,$SCHEME \
  --module $MODULE \
  --root-url https://alexaubry.github.io/$MODULE \
  --output docs/ \
  --swift-version 3.0.2 \
  --copyright "Copyright © 2016-2017 Alexis Aubry Radanovic. Licensed under the [MIT License](https://github.com/alexaubry/HTMLString/blob/master/LICENSE)" \
  --podspec ./$MODULE.podspec \
  --skip-undocumented