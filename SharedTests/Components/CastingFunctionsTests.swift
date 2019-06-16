//
//  CastingFunctionsTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
