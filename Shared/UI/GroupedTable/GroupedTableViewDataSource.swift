//
//  GroupedTableViewDataSource.swift
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
