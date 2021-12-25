//
//  LocationDelegateHandler.swift
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

public protocol CLLocationProtocol {
    var coordinate: CLLocationCoordinate2D { get }
    var timestamp: Date { get }
    var horizontalAccuracy: CLLocationAccuracy { get }
}

extension CLLocation: CLLocationProtocol {}

public enum LocationRequestError: Error, Equatable {
    case noLocationsReturned
    case invalidHorizontalAccuracy
    case coreLocationError(CLError)
    case unknownError(IgnoredEquatable<Error>)
}

public typealias LocationRequestResult = Result<LocationCoordinate, LocationRequestError>

public protocol LocationDelegateHandlerProtocol: AutoMockable {
    func resultForDidUpdateLocations(_ locations: [CLLocationProtocol],
                                     dateManagerInitialized: Date) -> LocationRequestResult?

    func resultForDidFailWithError(_ error: Error) -> LocationRequestResult?
}

public class LocationDelegateHandler: LocationDelegateHandlerProtocol {

    public init() {}

    public func resultForDidUpdateLocations(_ locations: [CLLocationProtocol],
                                            dateManagerInitialized: Date) -> LocationRequestResult? {
        // https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423615-locationmanager
        //
        //   "This array always contains at least one object representing the current location...the most recent
        //    location update is at the end of the array".
        guard let mostRecentLocation = locations.last else {
            return .failure(.noLocationsReturned)
        }

        // https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate
        //
        //   "Core Location may report a cached value to your delegate immediately after you start the service, followed
        //    by a more current value later. Check the time stamp of any data objects you receive before using them."
        //
        // Note that this only applies to values received immediately after starting the service. At later times, I've
        // seen iOS return a CLLocation, with an old timestamp, that's nevertheless still valid (meaning the user's
        // location didn't change significantly enough). -JP
        guard mostRecentLocation.timestamp > dateManagerInitialized else {
            return nil
        }

        // https://developer.apple.com/documentation/corelocation/cllocation/1423599-horizontalaccuracy
        //
        //   "A negative [horizontalAccuracy] indicates that the latitude and longitude are invalid."
        guard mostRecentLocation.horizontalAccuracy > 0 else {
            return .failure(.invalidHorizontalAccuracy)
        }

        let coordinate = LocationCoordinate(location: mostRecentLocation)
        return .success(coordinate)
    }

    public func resultForDidFailWithError(_ error: Error) -> LocationRequestResult? {
        guard let clError = error as? CLError else {
            return .failure(.unknownError(IgnoredEquatable(error)))
        }

        // https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager
        //
        //   "If the location service is unable to retrieve a location right away, it reports a
        //    CLError.Code.locationUnknown error and keeps trying. In such a situation, you can
        //    simply ignore the error and wait for a new event."
        guard clError.code != .locationUnknown else {
            return nil
        }

        return .failure(.coreLocationError(clError))
    }

}
