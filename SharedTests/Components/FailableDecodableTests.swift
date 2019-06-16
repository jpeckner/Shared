//
//  FailableDecodableTests.swift
//  SharedTests
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
