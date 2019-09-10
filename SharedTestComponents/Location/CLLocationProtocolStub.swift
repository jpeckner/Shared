//
//  CLLocationProtocolStub.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation
import Foundation
import Shared

public struct CLLocationProtocolStub: CLLocationProtocol {
    public let coordinate: CLLocationCoordinate2D
    public let timestamp: Date
    public let horizontalAccuracy: CLLocationAccuracy

    public init(coordinate: CLLocationCoordinate2D,
                timestamp: Date,
                horizontalAccuracy: CLLocationAccuracy) {
        self.coordinate = coordinate
        self.timestamp = timestamp
        self.horizontalAccuracy = horizontalAccuracy
    }
}
