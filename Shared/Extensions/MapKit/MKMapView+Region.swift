//
//  MKMapView+Region.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import MapKit

public extension MKMapView {

    func annotateLocation(_ coordinate: CLLocationCoordinate2D,
                          title: NonEmptyString,
                          subtitle: NonEmptyString? = nil) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title.value
        annotation.subtitle = subtitle?.value

        addAnnotation(annotation)
    }

    // Adopted from https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
    func centerOnLocation(_ coordinate: CLLocationCoordinate2D,
                          regionRadius: CLLocationDistance,
                          animated: Bool = true) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)

        setRegion(coordinateRegion,
                  animated: animated)
    }

}
