//
//  UIColorDecodable.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public struct UIColorDecodable: Equatable {
    public let value: UIColor

    public init(value: UIColor) {
        self.value = value
    }
}

extension UIColorDecodable: Decodable {

    public init(from decoder: Decoder) throws {
        let hexString = try decoder.singleValueContainer().decode(String.self)
        self.value = try UIColor(hexString: hexString)
    }

}
