//
//  StringCharacterSetTests.swift
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

class StringCharacterSetTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("deletingPrefix()") {

            var result: String!

            context("when the string is empty") {
                beforeEach {
                    result = "".deletingPrefix("Hello's")
                }

                it("returns the original string") {
                    expect(result) == ""
                }
            }

            context("else when the string does not have the given prefix") {
                beforeEach {
                    result = "Hello world!".deletingPrefix("Hello's")
                }

                it("returns the original string") {
                    expect(result) == "Hello world!"
                }
            }

            context("else when the string has the given prefix") {
                beforeEach {
                    result = "Hello world!".deletingPrefix("Hello")
                }

                it("returns the original string minus the prefix") {
                    expect(result) == " world!"
                }
            }

        }

    }

}
