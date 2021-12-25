//
//  TabSelectionViewController.swift
//  Shared
//
//  Copyright (c) 2020 Justin Peckner
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
