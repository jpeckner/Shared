//
//  IgnoredEquatableTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared

private struct NotEquatable {}

class IgnoredEquatableTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("==") {

            var equal: Bool!

            context("when T implements Equatable") {

                context("and two IgnoredEquatable objects with the same value are compared") {
                    beforeEach {
                        equal = IgnoredEquatable(5) == IgnoredEquatable(5)
                    }

                    it("returns true") {
                        expect(equal) == true
                    }
                }

                context("and two IgnoredEquatable objects with different values are compared") {
                    beforeEach {
                        equal = IgnoredEquatable(5) == IgnoredEquatable(10)
                    }

                    it("returns true") {
                        expect(equal) == true
                    }
                }

            }

            context("when T does not implement Equatable") {
                beforeEach {
                    equal = IgnoredEquatable(NotEquatable()) == IgnoredEquatable(NotEquatable())
                }

                it("returns true") {
                    expect(equal) == true
                }
            }

        }

    }

}
