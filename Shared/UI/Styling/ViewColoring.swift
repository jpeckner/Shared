//
//  ViewColoring.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

public struct ViewColoring: Equatable {
    public let backgroundColor: UIColor

    public init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

extension ViewColoring: Decodable {

    enum CodingKeys: String, CodingKey {
        case backgroundColor
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backgroundColor = try container.decode(UIColorDecodable.self,
                                                    forKey: .backgroundColor).value
    }

}
