//
//  NonEmptyArrayTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared

class NonEmptyArrayTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("init(with:)") {
            var array: NonEmptyArray<String>!
            beforeEach {
                array = NonEmptyArray(with: "hello")
            }

            it("encapsulates the same value passed to init") {
                expect(array?.value) == ["hello"]
            }
        }

        describe("init?(_ value:)") {
            var array: NonEmptyArray<String>?

            context("when init is passed an empty array") {
                beforeEach {
                    array = NonEmptyArray([])
                }

                it("returns nil") {
                    expect(array).to(beNil())
                }
            }

            context("when init is passed a non-empty array") {
                beforeEach {
                    array = NonEmptyArray(["hello"])
                }

                it("encapsulates the same array passed to init") {
                    expect(array?.value) == ["hello"]
                }
            }
        }

        describe("first") {
            var array: NonEmptyArray<String>!

            beforeEach {
                array = NonEmptyArray(["hello", "there", "everyone"])
            }

            it("returns the last element") {
                expect(array.first) == "hello"
            }
        }

        describe("last") {
            var array: NonEmptyArray<String>!

            beforeEach {
                array = NonEmptyArray(["hello", "there", "everyone"])
            }

            it("returns the last element") {
                expect(array.last) == "everyone"
            }
        }

        describe("replacingLast") {
            var modifiedArray: NonEmptyArray<String>!

            beforeEach {
                modifiedArray = NonEmptyArray(["hello", "there", "everyone"])?.replacingLast(with: "world")
            }

            it("returns the last element") {
                expect(modifiedArray.last) == "world"
            }
        }

        describe("appendedWith") {

            it("appends the arg to this instance's encapsulated array") {
                let originalArray = NonEmptyArray(["hello"])
                let augmentedArray = originalArray?.appendedWith(["there"])
                expect(augmentedArray?.value) == ["hello", "there"]
            }

        }

        describe("withTransformation") {

            it("maps the transformation block to each member of the encapsulated array") {
                let originalArray = NonEmptyArray([1, 2, 3])
                let transformedArray = originalArray?.withTransformation { int -> String in String(int) }
                expect(transformedArray?.value) == ["1", "2", "3"]
            }

        }

    }

}
