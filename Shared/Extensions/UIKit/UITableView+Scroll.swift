//
//  UITableView+Scroll.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UITableView {

    func scrollToTop(animated: Bool) {
        scrollToPosition(indexPath: IndexPath(row: 0, section: 0),
                         scrollPosition: .top,
                         animated: animated)

        setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }

    func scrollToPosition(indexPath: IndexPath,
                          scrollPosition: UITableView.ScrollPosition,
                          animated: Bool) {
        guard numberOfSections > 0,
            numberOfRows(inSection: 0) > 0
        else { return }

        scrollToRow(at: indexPath,
                    at: scrollPosition,
                    animated: animated)
    }

}
