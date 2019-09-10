//
//  UITableViewCell+Appearance.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UITableViewCell {

    func makeSeparatorFullWidth() {
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        configureZeroInsetMargins()
    }

    func makeTransparent() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

}
