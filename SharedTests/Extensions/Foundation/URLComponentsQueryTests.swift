//
//  URLComponentsQueryTests.swift
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

class URLComponentsQueryTests: QuickSpec {

    override func spec() {

        describe("queryItem(:paramName)") {

            var result: URLQueryItem?

            // swiftlint:disable force_unwrapping
            func performTest(urlString: String) {
                result = URLComponents(string: urlString)!.queryItem(for: "myParam")
            }
            // swiftlint:enable force_unwrapping

            context("when the URLComponents instance has no query params") {
                beforeEach {
                    performTest(urlString: "https://www.example.com")
                }

                it("returns nil") {
                    expect(result).to(beNil())
                }
            }

            context("when the URLComponents instance has no query params with the matching name") {
                beforeEach {
                    performTest(urlString: "https://www.example.com/?paramOne=1&paramTwo=hello")
                }

                it("returns nil") {
                    expect(result).to(beNil())
                }
            }

            context("when the URLComponents instance has one param with the matching name") {
                beforeEach {
                    performTest(urlString: "https://www.example.com/?paramOne=1&myParam=hello%20world")
                }

                it("returns the query item for the param") {
                    expect(result) == URLQueryItem(name: "myParam", value: "hello world")
                }
            }

            context("when the URLComponents instance has multiple params with the matching name") {
                beforeEach {
                    performTest(urlString:
                        "https://www.example.com/?paramOne=1&myParam=hello%20world&paramTwo=2&myParam=goodbye%20moon"
                    )
                }

                it("returns the query item appearing first") {
                    expect(result) == URLQueryItem(name: "myParam", value: "hello world")
                }
            }

        }

    }

}
