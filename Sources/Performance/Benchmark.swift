/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   Benchmark.swift
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
import Dispatch

// MARK: Core

/// Repeats a block and returns the execution times for every iteration.
func repeatExec(_ block: () -> Void) -> [TimeInterval] {

    var times = [TimeInterval]()
    times.reserveCapacity(averageTimeSamplesCount)

    while times.count < averageTimeSamplesCount {

        let start = DispatchTime.now()
        block()
        let end = DispatchTime.now()

        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = TimeInterval(nanoTime) / 1_000_000_000

        times.append(timeInterval)

    }

    return times

}

/// Measures the average execution time of a block.
func measure(_ block: () -> Void) -> TimeInterval {

    let times = repeatExec(block)

    let sum = times.reduce(Double()) { $0 + $1 }
    let average = sum / Double(averageTimeSamplesCount)

    return Double(round(1_000_000*average)/1_000_000) // +/- 10^-6 average

}

// MARK: - Test

/// Computes the average time for every test block.
func testAverageTime() -> [Int: TimeInterval] {

    let averages: [(Int, TimeInterval)] = testBlocks.map {
        print("👉  \(tasks[$0.key]!)")
        return ($0.key, measure($0.value))
    }

    var dict = [Int: TimeInterval]()
    for (key, value) in averages {
        dict[key] = value
    }

    return dict

}

/// Computes the asymptotic complexity of every algorithm family.
func calculateComplexity() {

    func calc(for tasks: [Int], _ message: String) {

        print("❓  \(message)")

        let rawData: [[(Int, TimeInterval)]] = tasks.map {

            let block = testBlocks[$0]!
            let n = test_n[$0]!
            let times = repeatExec(block)

            return times.map {
                return (n, $0)
            }

        }

        let reducedData = rawData.reduce([(Int, TimeInterval)]()) {
            $0 + $1
        }

        let complexity = computeComplexity(for: reducedData)
        print(complexity.rawValue)

    }

    calc(for: unicodeEscapingTasks, "Calculating Unicode-escaping complexity")
    calc(for: asciiEscapingTasks, "Calculating ASCII-escaping complexity")
    calc(for: unescapingTasks, "Calculating unescaping complexity")

}

func table(from results: [Int: TimeInterval]) -> String {

    let sortedHistory = history.sorted { $0.key < $1.key }

    let v = sortedHistory.map { "| v\($0.key) " }.joined() + "| v\(version) |"
    let s = sortedHistory.map { _ in "|---" }.joined() + "|---|"

    let header = "| Task " + v
    let separator = "|:---" + s

    var lines = [header, separator]

    let sortedTasks = tasks.sorted { $0.key < $1.key }

    for (taskNumber, taskName) in sortedTasks {

        var _results: [String] = sortedHistory.map {
            if let num = $0.value[taskNumber] {
                return String(format: "%.06f", num)
            }
            return "N/A"
        }

        let current: String

        if let num = results[taskNumber] {
            current = String(format: "%.06f", num)
        } else {
            current = "N/A"
        }

        _results.append(current)

        let elements = _results.map {
            "| \($0)s "
        }.joined()

        let line = "| \(taskName) " + elements + "|"
        lines.append(line)

    }

    return lines.joined(separator: "\n")

}

func versionAppendix(for results: [Int: TimeInterval]) -> String {

    let sortedResults = results.sorted { $0.key < $1.key }

    let minified = sortedResults.reduce(String()) {
        let num = String(format: "%.06f", $1.value)
        return $0 + "\($1.key):\(num),"
    }

    return "\"\(version)\":[\(minified)]"

}
