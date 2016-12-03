MODULE=HTMLString
VERSION=2.0
SCHEME=HTMLString

jazzy \
  --clean \
  --author Alexis Aubry Radanovic \
  --author_url https://github.com/alexaubry \
  --github_url https://github.com/alexaubry/$MODULE \
  --github-file-prefix https://github.com/alexaubry/$MODULE/tree/master \
  --module-version $VERSION \
  --xcodebuild-arguments -scheme,$SCHEME \
  --module $MODULE \
  --root-url https://alexaubry.github.io/$MODULE \
  --output docs/
