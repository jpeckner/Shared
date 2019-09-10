// swiftlint:disable:this file_name
//
//  URLRequest+InitTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
