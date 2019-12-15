//
//  GroupedTableViewDataSource.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public class GroupedTableViewDataSource: NSObject {
    public private(set) var tableModel: GroupedTableViewModel

    public init(tableModel: GroupedTableViewModel) {
        self.tableModel = tableModel
    }
}

extension GroupedTableViewDataSource {

    func configure(_ tableModel: GroupedTableViewModel) {
        self.tableModel = tableModel
    }

}

extension GroupedTableViewDataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableModel.sectionModels.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.sectionModels[section].cellModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellStyle = tableModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withCellType: cellStyle.cellType, for: indexPath)

        AssertionHandler.assertIfErrorThrown {
            try cellStyle.customizeCell(cell)
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableModel.sectionModels[section].title
    }

}

private extension GroupedTableViewCellModel {

    func customizeCell(_ cell: UITableViewCell) throws {
        switch self {
        case let .basic(viewModel):
            cell.textLabel?.text = viewModel.title
            cell.imageView?.image = viewModel.image
            cell.accessoryType = viewModel.accessoryType
        }
    }

}
