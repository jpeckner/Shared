//
//  NonEmptyStringTests.swift
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

class NonEmptyStringTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("init") {

            var thrownError: Error?
            var result: NonEmptyString?

            context("when init is passed an empty string") {
                beforeEach {
                    thrownError = errorThrownBy {
                        _ = try NonEmptyString("")
                    }
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when init is passed a non-empty string") {
                beforeEach {
                    thrownError = errorThrownBy {
                        result = try NonEmptyString("hello")
                    }
                }

                it("does not throw an error") {
                    expect(thrownError).to(beNil())
                }

                it("encapsulates the same string passed to init") {
                    expect(result?.value) == "hello"
                }
            }

        }

        describe("asStringArray") {
            var result: [String]!

            beforeEach {
                let nonEmptyArray = NonEmptyArray(with: NonEmptyString.stubValue("A")).appendedWith([
                    NonEmptyString.stubValue("B"),
                    NonEmptyString.stubValue("C")
                ])

                result = nonEmptyArray.asStringArray
            }

            it("returns the same values in a String array") {
                expect(result) == ["A", "B", "C"]
            }
        }

        describe("joined()") {
            var result: NonEmptyString!

            beforeEach {
                let nonEmptyArray = NonEmptyArray(with: NonEmptyString.stubValue("A")).appendedWith([
                    NonEmptyString.stubValue("B"),
                    NonEmptyString.stubValue("C")
                ])

                result = nonEmptyArray.joined("zzz")
            }

            it("returns the same values in a String array") {
                expect(result) == NonEmptyString.stubValue("AzzzBzzzC")
            }
        }

    }

}
