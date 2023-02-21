//
//  LocationRequestHandler.swift
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

import CoreLocation
import Foundation

// sourcery: AutoMockable
public protocol LocationRequestHandlerProtocol {
    func requestLocation() async -> LocationRequestResult
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

    public func requestLocation() async -> LocationRequestResult {
        await withCheckedContinuation { [weak self] continuation in
            self?.callbacksQueue.async { [weak self] in
                let callback = LocationResultCallback(continuation: continuation)
                self?.resultCallbacks.append(callback)
            }

            self?.locationManager.startUpdatingLocation()
        }
    }

}

extension LocationRequestHandler: CLLocationManagerDelegate {

    @objc
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let result = delegateHandler.resultForDidUpdateLocations(
            locations,
            dateManagerInitialized: dateInitialized
        ) else {
            return
        }

        notifyCallbacks(result)
    }

    @objc
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let result = delegateHandler.resultForDidFailWithError(error) else {
            return
        }

        notifyCallbacks(result)
    }

    private func notifyCallbacks(_ result: LocationRequestResult) {
        locationManager.stopUpdatingLocation()

        callbacksQueue.async { [weak self] in
            self?.handleNotifyCallbacks(result)
        }
    }

    private func handleNotifyCallbacks(_ result: LocationRequestResult) {
        resultCallbacks = resultCallbacks.filter { $0.callbackInvocation != nil }

        resultCallbacks.forEach { callback in
            callback.callbackInvocation?(result)
        }
    }

}

private class LocationResultCallback {
    var callbackInvocation: ((LocationRequestResult) -> Void)?

    init(continuation: CheckedContinuation<LocationRequestResult, Never>) {
        self.callbackInvocation = { [weak self] result in
            continuation.resume(returning: result)
            self?.callbackInvocation = nil
        }
    }
}
