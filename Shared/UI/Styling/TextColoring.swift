//
//  TextColoring.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

public struct TextColoring: Equatable {
    public let textColor: UIColor

    public init(textColor: UIColor) {
        self.textColor = textColor
    }
}

extension TextColoring: Decodable {

    enum CodingKeys: String, CodingKey {
        case textColor
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.textColor = try container.decode(UIColorDecodable.self,
                                              forKey: .textColor).value
    }

}
