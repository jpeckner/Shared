// swiftlint:disable:this file_name
//
//  URLRequest+InitTests.swift
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

class URLRequestInitTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("init()") {
            let stubURL = URL.stubValue(string: "https://www.example.com/path/to/somewhere")
            let stubHeaders = [
                "headerKeyOne": "headerValueOne",
                "headerKeyTwo": "headerValueTwo",
                "headerKeyThree": "headerValueThree"
            ]

            var result: URLRequest!

            beforeEach {
                result = URLRequest(url: stubURL, type: .GET, headers: stubHeaders)
            }

            it("initializes the URLRequest with the provided URL") {
                expect(result.url) == stubURL
            }

            it("initializes the URLRequest with the provided httpMethod") {
                expect(result.httpMethod) == "GET"
            }

            it("initializes the URLRequest with the provided headers") {
                expect(result.allHTTPHeaderFields) == stubHeaders
            }

        }

    }

}
