//
//  FillColoring.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public struct FillColoring: Equatable {
    public let color: UIColor

    public init(color: UIColor) {
        self.color = color
    }
}

extension FillColoring: Decodable {

    enum CodingKeys: String, CodingKey {
        case color
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.color = try container.decode(UIColorDecodable.self, forKey: .color).value
    }

}
