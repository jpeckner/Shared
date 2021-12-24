//
//  CastingFunctionsTests.swift
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

import Nimble
import Quick
import Shared
import SharedTestComponents

private class SuperClass {}
private class SubClassOne: SuperClass {}
private class SubClassOfSubClassOne: SubClassOne {}
private class SubClassTwo: SuperClass {}

private class UnrelatedClass {}

class CastingFunctionsTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("cast") {

            var thrownError: Error?
            var superClassReference: SuperClass!
            var result: SubClassOne?

            context("when the cast reference has no common ancestor with the desired type") {
                beforeEach {
                    thrownError = errorThrownBy {
                        result = try CastingFunctions.cast(UnrelatedClass() as Any)
                    }
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the cast reference has a common ancestor but is not the same kind as the desired type") {
                beforeEach {
                    superClassReference = SubClassTwo()

                    thrownError = errorThrownBy {
                        result = try CastingFunctions.cast(superClassReference as Any)
                    }
                }

                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }
            }

            context("when the cast reference points to an object with exactly the same desired type") {
                beforeEach {
                    superClassReference = SubClassOne()

                    thrownError = errorThrownBy {
                        result = try CastingFunctions.cast(superClassReference as Any)
                    }
                }

                it("sets result to that reference") {
                    expect(result) === superClassReference
                }
            }

            context("when the cast reference points to a descendent of the desired type") {
                beforeEach {
                    superClassReference = SubClassOfSubClassOne()

                    thrownError = errorThrownBy {
                        result = try CastingFunctions.cast(superClassReference as Any)
                    }
                }

                it("sets result to that reference") {
                    expect(result) === superClassReference
                }
            }

        }

    }

}
