//
//  ActionableButton.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public class ActionableButton: UIButton {

    private let touchUpInsideCallback: () -> Void

    public init(touchUpInsideCallback: @escaping () -> Void) {
        self.touchUpInsideCallback = touchUpInsideCallback

        super.init(frame: .zero)

        addTarget(self,
                  action: #selector(handleTouchUpInside),
                  for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func handleTouchUpInside() {
        touchUpInsideCallback()
    }

}
