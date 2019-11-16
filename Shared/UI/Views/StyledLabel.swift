//
//  StyledLabel.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import SwiftUI
import UIKit

public class StyledLabel: UILabel {

    public var textLayout: TextLayout {
        didSet {
            applyTextLayout(textLayout)
        }
    }

    public var textColoring: TextColoring {
        didSet {
            applyTextColoring(textColoring)
        }
    }

    public init(textLayout: TextLayout = TextLayout(font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                                                    alignment: .left),
                textColoring: TextColoring = TextColoring(textColor: .black),
                numberOfLines: Int = 0) {
        self.textLayout = textLayout
        self.textColoring = textColoring

        super.init(frame: .zero)

        self.numberOfLines = numberOfLines
        applyTextLayout(textLayout)
        applyTextColoring(textColoring)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
