// swiftlint:disable:this file_name
//
//  HTTPURLResponse+ErrorTests.swift
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

class HTTPURLResponseErrorTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("is400Error") {
            var result: Bool!

            context("when the error status code equals 400") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 400)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code equals 499") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 499)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code falls in-between that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 450)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code does not fall in that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 399)
                    result = response.is400Error
                }

                it("returns false") {
                    expect(result) == false
                }
            }
        }

        describe("is500Error") {
            var result: Bool!

            context("when the error status code equals 500") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 500)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code equals 599") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 599)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code falls in-between that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 550)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code does not fall in that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 499)
                    result = response.is500Error
                }

                it("returns false") {
                    expect(result) == false
                }
            }
        }

    }

}
