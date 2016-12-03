# HTMLString

![Swift 3.0.1](https://img.shields.io/badge/Swift-3.0.1-ee4f37.svg)
![License](https://img.shields.io/badge/License-MIT-000000.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/HTMLString.svg)](https://cocoapods.org/pods/HTMLString)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/alexaubry/HTMLString.svg?branch=master)](https://travis-ci.org/alexaubry/HTMLString)
[![codecov](https://codecov.io/gh/alexaubry/HTMLString/branch/master/graph/badge.svg)](https://codecov.io/gh/alexaubry/HTMLString)
[![Twitter : @leksantoine](https://img.shields.io/badge/Twitter-%40leksantoine-6C7A89.svg)](https://twitter.com/leksantoine)

`HTMLString` is a micro-library written in Swift that enables your app to encode and decode Strings that contain HTML escapes.

📚  [Documentation](https://alexaubry.github.io/HTMLString)

## Features

- ASCII and Unicode Escaping
- Unescaping
- Full support of Swift extended grapheme clusters
- Support of 2125 named escape sequences (`&amp;`) as well as decimal (`&#128;`) and hexadecimal (`&#x1F643;`) sequences

## Platforms

- iOS 8.0+
- macOS 10.10+
- tvOS 9.0+
- watchOS 2.0+
- Linux

## Installation

### Swift Package Manager

Add this line to your `Package.swift` :

~~~swift
.Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 2, minor: 0)
~~~

### CocoaPods

Add this line to your `Podfile`:

~~~
pod 'HTMLString'
~~~

### Carthage

Add this line to your Cartfile:

~~~
github "alexaurby/HTMLString"
~~~

### Manual

Add the contents of `Sources` directory to your project.

## Usage

This library adds three properties to String instances:

- `escapingForUnicodeHTML`: Escapes the characters in the String for display in Unicode-encoded HTML pages.
- `escapingForASCIIHTML` : Escapes the characters in the String for display in ASCII-encoded HTML pages
- `unescapingFromHTML` : Replaces all escape sequences in the String by their corresponding Unicode Scalar.

You can also escape individual characters using these `Character` extensions:

- `escapingForASCII`
- `escapingForUnicode`

### Escaping

~~~swift
import HTMLString

let emoji = "My favorite emoji is 🙃"
let escapedEmoji = emoji.escapingForASCIIHTML // "My favorite emoji is &#128579;"

let snack = "Fish & Chips"
let escapedSnack = snack.escapingForUnicodeHTML // "Fish &amp; Chips"
~~~

### Unescaping

~~~swift
import HTMLString

let escapedEmoji = "My favorite emoji is &#x1F643;"
let emoji = escapedEmoji.unescapingFromHTML // "My favorite emoji is 🙃"

let escapedSnack = "Fish &amp; Chips"
let snack = escapedSnack.unescapingFromHTML // "Fish & Chips"
~~~

## Acknowledgements

This library was inspired by Google's `GTMNSString+HTML`.
