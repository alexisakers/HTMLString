# `import HTMLString`

![Build Status](https://travis-ci.org/alexaubry/HTMLString.svg?branch=master) ![Swift 3.0](https://img.shields.io/badge/Swift-3.0-Orange.svg) ![CocoaPods](https://img.shields.io/cocoapods/v/HTTPString.svg?maxAge=86400") ![The MIT License](https://img.shields.io/cocoapods/l/HTTPString.svg?maxAge=86400")

`HTMLString` is a micro-library written in Swift that enables your app to deal with Strings that contain HTML.

## Features

- [x] ASCII and Unicode Escaping
- [x] Unescaping
- [x] Support of 2125 named escape sequences (`&amp;`) as well as decimal (`&#128;`) and hexadecimal (`&#x1F643;`) sequences

## Supports

- [x] iOS 8.0
- [x] macOS 10.10
- [x] watchOS 2.0
- [x] tvOS 9.0
- [x] Linux

## Installation

### CocoaPods

Add this line to your `Podfile`:

~~~
pod 'HTMLString' '~> 1.0'
~~~

### Swift Package Manager

Add this line to your `Package.swift` :
~~~swift
.Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 1, minor: 0)
~~~

### Manual

Add the `HTMLString.swift` and `Mappings.swift` files to your project.

## Usage

This library adds three properties to String instances :

- `escapingForUnicodeHTML`: Escapes the characters in the String for display in Unicode-encoded HTML pages.
- `escapingForASCIIHTML` : Escapes the characters in the String for display in ASCII-encoded HTML pages
- `unescapingFromHTML` : Replaces all escape sequences in the String by their corresponding Unicode Scalar.

### Escaping

~~~swift
import HTMLString 

let emoji = "My favorite emoji is 🙃"
let escapedEmoji = escapingForASCIIHTML // "My favorite emoji is &#128579;"

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
