//
//  UIColorInitTests.swift
//  SharedTests
//
//  Copyright (c) 2019 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import Nimble
import Quick
import Shared
import SharedTestComponents

class UIColorInitTests: QuickSpec {

    // swiftlint:disable object_literal
    // swiftlint:disable function_body_length
    override func spec() {

        describe("init(:hexString)") {

            var thrownError: Error?
            var result: UIColor?

            func performTest(hexString: String) {
                thrownError = errorThrownBy {
                    result = try UIColor(hexString: hexString)
                }
            }

            context("when the string is not a valid hex string") {
                beforeEach {
                    performTest(hexString: "FFFFFG")
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the hex value is greater than 0xFFFFFF") {
                beforeEach {
                    performTest(hexString: "1000000")
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the string is equal to 0xFFFFFF") {
                beforeEach {
                    performTest(hexString: "FFFFFF")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: 1.0,
                                              green: 1.0,
                                              blue: 1.0,
                                              alpha: 1.0)
                }
            }

            context("when the string is equal to 0x000000") {
                beforeEach {
                    performTest(hexString: "000000")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: 0.0,
                                              green: 0.0,
                                              blue: 0.0,
                                              alpha: 1.0)
                }
            }

            context("when the string is in-between those limits") {
                beforeEach {
                    performTest(hexString: "FEDCBA")
                }

                it("returns the corresponding UIColor, with an alpha of 1.0") {
                    expect(result) == UIColor(red: CGFloat(254.0) / 255.0,
                                              green: CGFloat(220.0) / 255.0,
                                              blue: CGFloat(186.0) / 255.0,
                                              alpha: 1.0)
                }
            }

            context("when the string includes a 0x prefix") {
                beforeEach {
                    performTest(hexString: "0xFEDCBA")
                }

                it("returns the same result as no-prefix") {
                    expect(result) == UIColor(red: CGFloat(254.0) / 255.0,
                                              green: CGFloat(220.0) / 255.0,
                                              blue: CGFloat(186.0) / 255.0,
                                              alpha: 1.0)
                }
            }

        }

    }

}
