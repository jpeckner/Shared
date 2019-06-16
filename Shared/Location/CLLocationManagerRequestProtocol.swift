//
//  CLLocationManagerRequestProtocol.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation

public protocol CLLocationManagerRequestProtocol: AnyObject, AutoMockable {
    var delegate: CLLocationManagerDelegate? { get set }

    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension CLLocationManager: CLLocationManagerRequestProtocol {}
