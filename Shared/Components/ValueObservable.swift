//
//  ValueObservable.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2020 Justin Peckner. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
public class ValueObservable<TValue>: ObservableObject {
    @Published public var value: TValue

    public init(value: TValue) {
        self._value = Published(initialValue: value)
    }
}
