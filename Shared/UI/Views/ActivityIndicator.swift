//
//  ActivityIndicator.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import SwiftUI

// Source: https://stackoverflow.com/a/56496896/1342984
@available(iOS 13.0.0, *)
public struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: UIColor

    // swiftlint:disable identifier_name
    public init(_isAnimating: Binding<Bool>,
                style: UIActivityIndicatorView.Style,
                color: UIColor) {
        self._isAnimating = _isAnimating
        self.style = style
        self.color = color
    }
    // swiftlint:enable identifier_name

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style)
        indicatorView.color = color
        return indicatorView
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView,
                             context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }

}
