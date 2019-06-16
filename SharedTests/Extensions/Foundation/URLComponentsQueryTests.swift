//
//  URLComponentsQueryTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
