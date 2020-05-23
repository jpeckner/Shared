//
//  EdgeInsets+Init.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2020 Justin Peckner. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension EdgeInsets {

    init(uniformInset: CGFloat) {
        self.init(top: uniformInset,
                  leading: uniformInset,
                  bottom: uniformInset,
                  trailing: uniformInset)
    }

}
