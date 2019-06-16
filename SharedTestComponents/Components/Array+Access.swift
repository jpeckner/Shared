//
//  Array+Access.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public extension Array {

    func element(at index: Int) -> Element? {
        guard count > index else { return nil }

        return self[index]
    }

}
