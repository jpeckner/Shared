//
//  FailableDecodable.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

/// See FailableDecodableTests for important notes/use-cases of this struct.
public struct FailableDecodable<D: Decodable> {
    public let value: D?
}

extension FailableDecodable: Decodable {

    public init(from decoder: Decoder) throws {
        self.value = try? decoder.singleValueContainer().decode(D.self)
    }

}

extension FailableDecodable: Equatable where D: Equatable {}
