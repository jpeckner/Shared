//
//  Array+Index.swift
//  Shared
//
//  Created by Justin Peckner on 4/30/23.
//

import Foundation

public extension Array {

    var indexed: [EnumeratedSequence<[Element]>.Element] {
        enumerated().map { $0 }
    }

}
