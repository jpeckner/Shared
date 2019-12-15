//
//  GroupedTableView.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public class GroupedTableView: UITableView {

    public let staticDataSource: GroupedTableViewDataSource

    public convenience init(tableModel: GroupedTableViewModel) {
        self.init(staticDataSource: GroupedTableViewDataSource(tableModel: tableModel))
    }

    public init(staticDataSource: GroupedTableViewDataSource) {
        self.staticDataSource = staticDataSource

        super.init(frame: .zero, style: .grouped)

        dataSource = staticDataSource
        GroupedTableViewCellModel.allCellTypes.forEach { register($0) }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public extension GroupedTableView {

    func configure(_ tableModel: GroupedTableViewModel) {
        guard tableModel != staticDataSource.tableModel else { return }

        staticDataSource.configure(tableModel)
        reloadData()
    }

}
