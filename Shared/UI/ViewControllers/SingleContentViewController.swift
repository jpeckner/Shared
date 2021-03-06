//
//  SingleContentViewController.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import UIKit

open class SingleContentViewController: UIViewController {

    private let contentView: UIView

    public var viewColoring: ViewColoring {
        didSet {
            guard isViewLoaded else { return }
            view.backgroundColor = viewColoring.backgroundColor
        }
    }

    public init(contentView: UIView,
                viewColoring: ViewColoring) {
        self.contentView = contentView
        self.viewColoring = viewColoring

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.fitSafely(to: view)

        // Ensure that background color fills the entire view, not just the safe area
        contentView.backgroundColor = .clear
        view.backgroundColor = viewColoring.backgroundColor
    }

}
