//
//  FailableDecodableTests.swift
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

import Foundation
import Nimble
import Quick
import Shared

private struct TestDecodable: Decodable, Equatable {
    let plainInt: Int
    let failableInt: FailableDecodable<Int>
}

class FailableDecodableTests: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {

        let decoder = JSONDecoder()
        var decodedObject: TestDecodable?
        var thrownError: Error?

        func performTest(json: String) {
            guard let data = json.data(using: .utf8) else {
                fail("Unexpected nil value")
                return
            }

            do {
                decodedObject = try decoder.decode(TestDecodable.self, from: data)
            } catch {
                thrownError = error
            }
        }

        beforeEach {
            decodedObject = nil
            thrownError = nil
        }

        describe("decode") {

            context("when the corresponding field contains a value of correct type") {

                beforeEach {
                    let json = """
                    {
                        "plainInt": 10,
                        "failableInt": 20
                    }
                    """
                    performTest(json: json)
                }

                it("sets value to the field's value") {
                    expect(decodedObject).toNot(beNil())
                    expect(decodedObject?.plainInt) == 10
                    expect(decodedObject?.failableInt.value) == 20
                }

            }

            context("when the corresponding field contains a value of incorrect type") {

                beforeEach {
                    let json = """
                    {
                        "plainInt": 10,
                        "failableInt": "NotAnInt"
                    }
                    """
                    performTest(json: json)
                }

                it("sets value to nil") {
                    expect(decodedObject).toNot(beNil())
                    expect(decodedObject?.plainInt) == 10
                    expect(decodedObject?.failableInt.value).to(beNil())
                }

            }

            context("when the corresponding field is missing") {

                beforeEach {
                    let json = """
                    {
                        "plainInt": 10,
                        "notFailableInt": 20
                    }
                    """
                    performTest(json: json)
                }

                // This isn't behavior that FailableDecodable actually has any control over, but it's an illustrative
                // test nonetheless. In cases where it's okay to decode the overall object even if the FailableDecodable
                // field is missing from the decoded data, mark the FailableDecodable field as optional. For example, in
                // TestDecodable, change the field declaration to:
                //
                //     let failableInt: FailableDecodable<Int>?
                //
                it("throws an error") {
                    expect(thrownError).toNot(beNil())
                }

            }

        }

    }

}
