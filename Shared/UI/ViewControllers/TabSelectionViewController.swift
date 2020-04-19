//
//  TabSelectionViewController.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2020 Justin Peckner. All rights reserved.
//

import UIKit

public protocol TabSelectionViewControllerDelegate: AnyObject {
    func viewController(_ tabSelectionViewController: TabSelectionViewController,
                        didSelectIndex index: Int,
                        previousIndex: Int)
}

public class TabSelectionViewController: UITabBarController {

    public weak var tabSelectionViewControllerDelegate: TabSelectionViewControllerDelegate?
    private var previousIndex = 0

    override public var selectedViewController: UIViewController? {
        willSet {
            previousIndex = selectedIndex
        }
    }

    public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers

        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TabSelectionViewController {

    // Using traitCollectionDidChange() would be preferrable, but iOS 13 no longer calls that method when the view
    // controller initially loads: https://useyourloaf.com/blog/predicting-size-classes-in-ios-13/
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        adjustTabImageInsets()
    }

    private func adjustTabImageInsets() {
        guard let horizontalSizeClass = horizontalSpecifiedClass else { return }

        adjustTabImageInsets(horizontalSizeClass)
    }

}

extension TabSelectionViewController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController,
                                 didSelect viewController: UIViewController) {
        guard selectedIndex != previousIndex else { return }

        tabSelectionViewControllerDelegate?.viewController(self,
                                                           didSelectIndex: selectedIndex,
                                                           previousIndex: previousIndex)
        previousIndex = selectedIndex
    }

}
