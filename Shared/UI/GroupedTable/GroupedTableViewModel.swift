//
//  GroupedTableViewModel.swift
//  Shared
//
//  Copyright (c) 2019 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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

// sourcery: AutoCellType
public enum GroupedTableViewCellModel: Equatable {
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
