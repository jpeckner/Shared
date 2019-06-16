//
//  Cells.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public extension UITableViewCell {

    static var cellIdentifier: String {
        return String(describing: self)
    }

}

public extension UITableView {

    func register(_ cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.cellIdentifier)
    }

    func dequeueReusableCell(withCellType type: UITableViewCell.Type, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: type.cellIdentifier, for: indexPath)
    }

}
