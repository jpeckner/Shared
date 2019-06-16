// swiftlint:disable:this file_name
//
//  HTTPURLResponse+ErrorTests.swift
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

class HTTPURLResponseErrorTests: QuickSpec {

    // swiftlint:disable function_body_length
    // swiftlint:disable implicitly_unwrapped_optional
    override func spec() {

        describe("is400Error") {
            var result: Bool!

            context("when the error status code equals 400") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 400)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code equals 499") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 499)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code falls in-between that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 450)
                    result = response.is400Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code does not fall in that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 399)
                    result = response.is400Error
                }

                it("returns false") {
                    expect(result) == false
                }
            }
        }

        describe("is500Error") {
            var result: Bool!

            context("when the error status code equals 500") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 500)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code equals 599") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 599)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code falls in-between that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 550)
                    result = response.is500Error
                }

                it("returns true") {
                    expect(result) == true
                }
            }

            context("else when the error status code does not fall in that range") {
                beforeEach {
                    let response = HTTPURLResponse.stubValue(statusCode: 499)
                    result = response.is500Error
                }

                it("returns false") {
                    expect(result) == false
                }
            }
        }

    }

}
