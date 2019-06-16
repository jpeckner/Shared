// swiftlint:disable:this file_name
//
//  URL+PathTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared

class URLPathTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("pathComponentsSansSlash") {

            var result: [String]!

            context("when the URL has a path") {
                beforeEach {
                    let url = URL.stubValue(string: "https://www.example.com/path/to/somewhere")
                    result = url.pathComponentsSansSlash
                }

                it("returns each separate component in an array") {
                    expect(result) == ["path", "to", "somewhere"]
                }
            }

            context("when the URL has a no path") {
                beforeEach {
                    let url = URL.stubValue(string: "https://www.example.com")
                    result = url.pathComponentsSansSlash
                }

                it("returns an empty array") {
                    expect(result) == []
                }
            }

        }

    }

}
