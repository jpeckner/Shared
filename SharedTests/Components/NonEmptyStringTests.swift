//
//  NonEmptyStringTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
