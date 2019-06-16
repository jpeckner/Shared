//
//  CLAuthorizationStatus+Cases.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation

public extension CLAuthorizationStatus {

    static let allCases: [CLAuthorizationStatus] = [
        .notDetermined,
        .restricted,
        .denied,
        .authorizedAlways,
        .authorizedWhenInUse,
    ]

}

extension CLAuthorizationStatus: CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        @unknown default:
            fatalError("Unknown CLAuthorizationStatus case: \(self)")
        }
    }

}
