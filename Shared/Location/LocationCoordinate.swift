//
//  LocationCoordinate.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation
import Foundation

// Replace this with CLLocationCoordinate2D if that type ever implements Hashable
public struct LocationCoordinate: Hashable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public extension LocationCoordinate {

    init(location: CLLocationProtocol) {
        self.init(latitude: location.coordinate.latitude,
                  longitude: location.coordinate.longitude)
    }

    var clCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude,
                                      longitude: longitude)
    }

}
