//
//  PercentageTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Shared

class PercentageTests: QuickSpec {

    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("init") {

            var result: Percentage!

            context("when the arg has a decimal value of zero") {
                beforeEach {
                    result = Percentage(decimalOf: 3.0)
                }

                it("sets value equal to 0") {
                    expect(result.value) == 0
                }
            }

            context("when the arg has a decimal value other than zero") {
                beforeEach {
                    result = Percentage(decimalOf: 3.147)
                }

                it("sets value equal to the decimal value") {
                    expect(result.value).to(beCloseTo(0.147))
                }
            }

        }

    }

}
