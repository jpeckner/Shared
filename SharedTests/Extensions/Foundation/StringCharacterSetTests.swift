//
//  StringCharacterSetTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
