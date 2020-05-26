//
//  View+Size.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2020 Justin Peckner. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension View {

    func frame(width: CGFloat,
               widthToHeightRatio: CGFloat) -> some View {
        let height = width / widthToHeightRatio

        return
            frame(idealWidth: width,
                  maxWidth: width,
                  idealHeight: height,
                  maxHeight: height)
            .fixedSize()
    }

    func frame(height: CGFloat,
               widthToHeightRatio: CGFloat) -> some View {
        let width = height * widthToHeightRatio

        return
            frame(idealWidth: width,
                  maxWidth: width,
                  idealHeight: height,
                  maxHeight: height)
            .fixedSize()
    }

}
