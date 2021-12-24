//
//  MKMapView+Region.swift
//  Shared
//
//  Copyright (c) 2019 Justin Peckner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
