//
//  CLLocationCoordinate2D+Location.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation

public extension CLLocationCoordinate2D {

    var clLocation: CLLocation {
        return CLLocation(latitude: latitude,
                          longitude: longitude)
    }

}
