# Updates to HTMLString

## 🔖 v5.0.0 — [Date TBD]

- Swift 5 support
- Improve unescaping algorithm speed
- Add mutable methods

## 🔖 v4.0.1 — 2018-05-08

- Update project for Xcode 9.3
- Improve tests and documentation

## 🔖 v4.0.1 — 2017-09-20

- Fix CocoaPods metadata

## 🔖 v4.0.0 — 2017-09-20

- Update project for Swift 4
- Improve tests and documentation
- Run CI tests on mutliple platforms
- Update metadata

## 🔖 v3.0.0 — 2017-02-14

- Implemented final API: same design as Foundation `addingPercentEncoding`/`removingPercentEncoding`
- Reorganized Xcode project and targets (1 target/platform)
- Better @objc annotations
- Automatic deployment from CI
- Fix Carthage minimum deployment version issue
- Updated README
- Sanitized codebase

## 🔖 v2.1.2 — 2017-01-16

- Added an Objective-C Mix & Match API
- Codebase improvements

## 🔖 v2.1.1 — 2017-01-05

### API

- You can now perform custom escaping by escaping Unicode scalars individually. 

### Improvements

- Further improved the escaping algorithm, which is now up to 6 times faster.
- Changed the escaping strategy: special characters are now escaped with decimal sequences. This allows for better compatibility with browsers (HTML 4.0 compatible) and better speed
- Changed the Unicode escaping strategy: only escape characters that could cause an XSS injection
- Added an asymptotic complexity approximation calculator (every algorithm is now O(N))

### Fixed

- Removed .DS_Store

## 🔖 v2.1.0 — 2017-01-04

- Changed the escaping algorithm (`reduce` instead of `map`)
- Reduced the size of the escaping mappings
- Performance improvements: escaping is up to **6.5 times** faster and unescaping is up to **98 times** faster
- Improved documentation
- New benchmark tool and reports

#### Source breaking changes

- The `Character` (un)escaping extensions have been removed. 

## 🔖 v2.0.1 — 2016-12-06

- Performance improvements : escaping is **99.37%** faster and unescaping is **10,38%** faster (in average)
- Changed the escaping/unescaping tables model
- Better tests and coverage

## 🔖 v2.0.0 — 2016-12-03

- Transitioned to a `Character`-based API: this adds full support for extended grapheme clusters.
- Reduced build times: now builds in ~5seconds (vs ~15 in v1)
- Rewrote tests: improved code coverage
- Several bug fixes and code improvements
- Added independent documentation

## 🔖 v1.0.2 — 2016-10-29

### Fixed

- `unescapingFromHTML` : An API difference between Darwin and Open-Source Foundation in `Scanner` caused compilation to fail on Linux.

### Improvements

- Tests on Linux and macOS
- Minor changes in README and Podspec
