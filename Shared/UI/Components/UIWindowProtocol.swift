//
//  UIWindowProtocol.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import UIKit

public protocol UIWindowProtocol: AnyObject, AutoMockable {
    var rootViewController: UIViewController? { get set }

    func makeKeyAndVisible()
}

extension UIWindow: UIWindowProtocol {}
