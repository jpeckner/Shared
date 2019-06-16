//
//  CLLocationManagerAuthProtocol.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2018 Justin Peckner. All rights reserved.
//

import CoreLocation

public protocol CLLocationManagerAuthProtocol: AnyObject, AutoMockable {
    var delegate: CLLocationManagerDelegate? { get set }

    func requestWhenInUseAuthorization()
}

extension CLLocationManager: CLLocationManagerAuthProtocol {}
