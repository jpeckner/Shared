//
//  Button+Styling.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension Button {

    func applyTextLayout(_ textLayout: TextLayout) -> some View {
        return font(Font(textLayout.font.ctFont))
    }

}
