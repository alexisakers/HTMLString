/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   Complexity.swift
 *  Project         :   HTMLString/Performance
 *  Author          :   Alexis Aubry Radanovic
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 * Adapted from https://github.com/google/benchmark.
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

/// An asymptotic complexity curve.
typealias BigOFunction = (Int) -> Double

/// A standard asymptotic complexity.
enum BigO: String {

    case o1 = "O(1)"
    case oN = "O(N)"
    case oNSquared = "O(N^2)"
    case oNCubed = "O(N^3)"
    case oLogN = "O(lgN)"
    case oNLogN = "O(NlgN)"

    var curve: BigOFunction {

        var wrappedFunc: (Double) -> Double

        switch self {
            case .o1: wrappedFunc = { _ in 1.0 }
            case .oN: wrappedFunc = { $0 }
            case .oNSquared: wrappedFunc = { $0 * $0 }
            case .oNCubed: wrappedFunc = { $0 * $0 * $0 }
            case .oLogN: wrappedFunc = { log2($0) }
            case .oNLogN: wrappedFunc = { $0 * log2($0) }
        }

        return { wrappedFunc(Double($0)) }

    }

    static var all: [BigO] {
        return [.oN, .oNSquared, .oNCubed, .oLogN, .oNLogN]
    }

}

struct LeastSquare {
    var coef: Double
    var rms: Double
}

func minimalSquareFit(for vector: [(Int, TimeInterval)], fitting complexity: BigO) -> LeastSquare {

    let curve = complexity.curve

    var sigma_gn = 0.0
    var sigma_gn_squared = 0.0
    var sigma_time = 0.0
    var sigma_time_gn = 0.0

    for (n, time) in vector {
        let gn_i = curve(n)
        sigma_gn += gn_i
        sigma_gn_squared += (gn_i * gn_i)
        sigma_time += time
        sigma_time_gn += (time * gn_i)
    }

    // Complexity
    let coef = sigma_time_gn / sigma_gn_squared

    // RMS
    let rms = vector.reduce(0.0) {
        let fit = coef * curve($1.0)
        return $0 + pow(($1.1 - fit), 2)
    }

    // Normalized RMS
    let mean = sigma_time / Double(vector.count)
    let std_rms = sqrt(rms / Double(vector.count)) / mean

    return LeastSquare(coef: coef, rms: std_rms)

}

func computeComplexity(for vector: [(Int, TimeInterval)]) -> BigO {

    var bestFit = minimalSquareFit(for: vector, fitting: .o1)
    var complexity = BigO.o1

    for fit in BigO.all {
        let currentFit = minimalSquareFit(for: vector, fitting: fit)
        if currentFit.rms < bestFit.rms {
            bestFit = currentFit
            complexity = fit
        }
    }

    return complexity

}
