//
//  GroupedTableViewModel.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public struct GroupedTableBasicCellViewModel: Equatable {
    public let title: String
    public let image: UIImage?
    public let accessoryType: UITableViewCell.AccessoryType

    public init(title: String,
                image: UIImage?,
                accessoryType: UITableViewCell.AccessoryType) {
        self.title = title
        self.image = image
        self.accessoryType = accessoryType
    }
}

public enum GroupedTableViewCellModel: Equatable, AutoCellType {
    // sourcery: cellType = "UITableViewCell"
    case basic(GroupedTableBasicCellViewModel)
}

public struct GroupedTableViewSectionModel: Equatable {
    public let title: String?
    public let cellModels: [GroupedTableViewCellModel]

    public init(title: String?,
                cellModels: [GroupedTableViewCellModel]) {
        self.title = title
        self.cellModels = cellModels
    }
}

public struct GroupedTableViewModel: Equatable {
    public let sectionModels: [GroupedTableViewSectionModel]

    public init(sectionModels: [GroupedTableViewSectionModel]) {
        self.sectionModels = sectionModels
    }
}
