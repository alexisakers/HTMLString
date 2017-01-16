/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   Configuration.swift
 *  Project         :   HTMLString/Performance
 *  Author          :   Alexis Aubry Radanovic
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016-2017 Alexis Aubry Radanovic
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import Foundation
import HTMLString

/// The number of samples to query for a single task.
let averageTimeSamplesCount = 1_000

/// The current version (to display in summary)
let version = "2.1.2"

/// The names of the tasks to execute.
let tasks = [
    1: "Unicode-escaping 2 emojis",
    2: "ASCII-escaping 2 emojis",
    3: "Unescaping 2 emojis",
    4: "Unescaping a tweet",
    5: "Unicode-escaping a tweet",
    6: "ASCII-escaping a tweet",
    7: "Unicode-escaping 23,145 characters",
    8: "ASCII-escaping 23,145 characters",
    9: "Unescaping 3,026 words with 366 escapes"
]

/// The number of elements in each task (for BigO notations)
let test_n = [
    1: 13,
    2: 13,
    3: 41,
    4: 156,
    5: 121,
    6: 121,
    7: 23145,
    8: 23145,
    9: 20713
]

let unicodeEscapingTasks = [1, 5, 7]
let asciiEscapingTasks = [2, 6, 8]
let unescapingTasks = [3, 4, 9]

// MARK: - Historical Data

#if DEBUG

let history: Dictionary<String, [Int:TimeInterval]> = [
    "2.0.1":[1:0.000083,2:0.000104,3:0.000046,4:0.000085,5:0.000844,6:0.001023,7:0.159909,8:0.198981,9:0.165962],
    "2.1.0":[1:0.000040,2:0.000035,3:0.000049,4:0.000033,5:0.000131,6:0.000158,7:0.024684,8:0.030419,9:0.001686],
    "2.1.1":[1:0.000006,2:0.000008,3:0.000021,4:0.000029,5:0.000056,6:0.000058,7:0.009895,8:0.010272,9:0.001706],
    "2.1.2":[1:0.000006,2:0.000007,3:0.000022,4:0.000030,5:0.000059,6:0.000061,7:0.010830,8:0.012069,9:0.001707]
]

#elseif RELEASE

let history: Dictionary<String, [Int:TimeInterval]> = [
    "2.0.1":[1:0.000022,2:0.000033,3:0.000031,4:0.000052,5:0.000183,6:0.000276,7:0.034701,8:0.052937,9:0.014192],
    "2.1.0":[1:0.000010,2:0.000015,3:0.000016,4:0.000017,5:0.000064,6:0.000077,7:0.011941,8:0.014950,9:0.001162],
    "2.1.1":[1:0.000004,2:0.000008,3:0.000012,4:0.000023,5:0.000047,6:0.000047,7:0.006806,8:0.007000,9:0.001204],
    "2.1.2":[1:0.000005,2:0.000005,3:0.000012,4:0.000022,5:0.000040,6:0.000042,7:0.006553,8:0.006850,9:0.001145]
]

#endif

/// The test blocks.
let testBlocks: [Int: () -> Void] = [
    1: {  _ = egc.escapingForUnicodeHTML },
    2: {  _ = egc.escapingForASCIIHTML },
    3: { _ = escapedEGC.unescapingFromHTML },
    4: { _ = escapedTweet.unescapingFromHTML },
    5: { _ = escapableTweet.escapingForUnicodeHTML },
    6: {  _ = escapableTweet.escapingForASCIIHTML },
    7: {  _ = bigEscapableText.escapingForUnicodeHTML },
    8: { _ = bigEscapableText.escapingForASCIIHTML },
    9: { _ = bigUnescapableText.unescapingFromHTML }
]
