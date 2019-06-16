//
//  LocationRequestHandler.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import CoreLocation
import Foundation

public protocol LocationRequestHandlerProtocol: AutoMockable {
    func requestLocation(_ callback: @escaping (LocationRequestResult) -> Void)
}

public class LocationRequestHandler: NSObject, LocationRequestHandlerProtocol {

    private let locationManager: CLLocationManagerRequestProtocol
    private let delegateHandler: LocationDelegateHandlerProtocol
    private let dateInitialized: Date
    private let callbacksQueue: DispatchQueue

    private var resultCallbacks: [LocationResultCallback] = []

    public init(locationManager: CLLocationManagerRequestProtocol,
                delegateHandler: LocationDelegateHandlerProtocol = LocationDelegateHandler()) {
        self.locationManager = locationManager
        self.delegateHandler = delegateHandler
        self.dateInitialized = Date()
        self.callbacksQueue = DispatchQueue(label: "LocationRequestHandler.callbacksQueue")

        super.init()

        locationManager.delegate = self
    }

    public func requestLocation(_ callback: @escaping (LocationRequestResult) -> Void) {
        callbacksQueue.async { [weak self] in
            self?.resultCallbacks.append(LocationResultCallback(resultCallback: callback))
            self?.locationManager.startUpdatingLocation()
        }
    }

}

extension LocationRequestHandler: CLLocationManagerDelegate {

    @objc
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let result = delegateHandler.resultForDidUpdateLocations(locations,
                                                                       dateManagerInitialized: dateInitialized)
        else { return }

        notifyCallbacks(result)
    }

    @objc
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let result = delegateHandler.resultForDidFailWithError(error) else { return }

        notifyCallbacks(result)
    }

    private func notifyCallbacks(_ result: LocationRequestResult) {
        locationManager.stopUpdatingLocation()

        callbacksQueue.async { [weak self] in
            self?.handleNotifyCallbacks(result)
        }
    }

    private func handleNotifyCallbacks(_ result: LocationRequestResult) {
        resultCallbacks = resultCallbacks.filter { $0.callback != nil }

        resultCallbacks.forEach {
            $0.callback?(result)
        }
    }

}

private class LocationResultCallback {
    var callback: ((LocationRequestResult) -> Void)?

    init(resultCallback: @escaping (LocationRequestResult) -> Void) {
        self.callback = { [weak self] result in
            resultCallback(result)
            self?.callback = nil
        }
    }
}
