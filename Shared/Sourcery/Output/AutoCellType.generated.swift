// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit


extension GroupedTableViewCellModel {

    static let allCellTypes: [UITableViewCell.Type] = [
        UITableViewCell.self,
    ]

    var cellType: UITableViewCell.Type {
        switch self {
        case .basic:
            return UITableViewCell.self
        }
    }

}
