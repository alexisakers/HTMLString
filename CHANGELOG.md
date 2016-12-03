# HTMLString Change Log

## 2016-12-03 — Version 2.0.0

- Transitioned to a `Character`-based API: this adds full support for extended grapheme clusters.
- Reduced build times: now builds in ~5seconds (vs ~15 in v1)
- Rewrote tests: improved code coverage
- Several bug fixes and code improvements
- Added independent documentation

## 2016-10-29 — Version 1.0.2

### Fixed

- `unescapingFromHTML` : An API difference between Darwin and Open-Source Foundation in `Scanner` caused compilation to fail on Linux.

### Improvements

- Tests on Linux and macOS
- Minor changes in README and Podspec
