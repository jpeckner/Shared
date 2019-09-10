//
//  UITableView+Setup.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UITableView {

    func performStandardSetup(cellTypes: [UITableViewCell.Type],
                              dataSource: UITableViewDataSource,
                              delegate: UITableViewDelegate? = nil,
                              estimatedRowHeight: CGFloat = 88.0,
                              showsVerticalScrollIndicator: Bool = false,
                              hidesExtraneousSeparatorLines: Bool = true,
                              extendsSeparatorsEdgeToEdge: Bool = true) {
        cellTypes.forEach { register($0) }

        self.dataSource = dataSource
        self.delegate = delegate
        self.estimatedRowHeight = estimatedRowHeight
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator

        if hidesExtraneousSeparatorLines {
            tableFooterView = UIView()
        }

        if extendsSeparatorsEdgeToEdge {
            extendSeparatorsEdgeToEdge()
        }
    }

    func extendSeparatorsEdgeToEdge() {
        separatorInsetReference = .fromCellEdges
        separatorInset = .zero
    }

}
