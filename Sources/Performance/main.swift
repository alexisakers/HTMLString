/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   main.swift
 *  Project         :   HTMLString/Performance
 *  Author          :   Alexis Aubry Radanovic
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 * A tool to measure the performance of escaping and unescaping.
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

print("🔬  HTMLString Performance Benchmark")

print()
calculateComplexity()
print()

let averageTime = testAverageTime()
let outputTable = table(from: averageTime)
let outputAppendix = versionAppendix(for: averageTime)

print()
print("✅  Benchmark Complete")

print()
print("📈  Results")
print()
print(outputTable)

print()

#if DEBUG
print("Add this line to the `DEBUG.history` dictionary in order")
#elseif RELEASE
print("Add this line to the `RELEASE.history` dictionary in order")
#endif

print("to reuse the results from this test:")
print(outputAppendix)
