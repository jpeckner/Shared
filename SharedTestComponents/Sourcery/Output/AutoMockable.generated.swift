// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import CoreLocation
import Shared
























public class CLLocationManagerAuthProtocolMock: CLLocationManagerAuthProtocol {

    public init() {}

    public var delegate: CLLocationManagerDelegate?

    //MARK: - requestWhenInUseAuthorization

    public var requestWhenInUseAuthorizationCallsCount = 0
    public var requestWhenInUseAuthorizationCalled: Bool {
        return requestWhenInUseAuthorizationCallsCount > 0
    }
    public var requestWhenInUseAuthorizationClosure: (() -> Void)?

    public func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationCallsCount += 1
        requestWhenInUseAuthorizationClosure?()
    }

}
public class CLLocationManagerRequestProtocolMock: CLLocationManagerRequestProtocol {

    public init() {}

    public var delegate: CLLocationManagerDelegate?

    //MARK: - startUpdatingLocation

    public var startUpdatingLocationCallsCount = 0
    public var startUpdatingLocationCalled: Bool {
        return startUpdatingLocationCallsCount > 0
    }
    public var startUpdatingLocationClosure: (() -> Void)?

    public func startUpdatingLocation() {
        startUpdatingLocationCallsCount += 1
        startUpdatingLocationClosure?()
    }

    //MARK: - stopUpdatingLocation

    public var stopUpdatingLocationCallsCount = 0
    public var stopUpdatingLocationCalled: Bool {
        return stopUpdatingLocationCallsCount > 0
    }
    public var stopUpdatingLocationClosure: (() -> Void)?

    public func stopUpdatingLocation() {
        stopUpdatingLocationCallsCount += 1
        stopUpdatingLocationClosure?()
    }

}
public class HTTPServiceProtocolMock: HTTPServiceProtocol, @unchecked Sendable {

    public init() {}


    //MARK: - performHTTPRequest

    public var performHTTPRequestUrlRequestSuccessStatusCodesCallsCount = 0
    public var performHTTPRequestUrlRequestSuccessStatusCodesCalled: Bool {
        return performHTTPRequestUrlRequestSuccessStatusCodesCallsCount > 0
    }
    public var performHTTPRequestUrlRequestSuccessStatusCodesReceivedArguments: (urlRequest: URLRequest, successStatusCodes: Set<Int>)?
    public var performHTTPRequestUrlRequestSuccessStatusCodesReceivedInvocations: [(urlRequest: URLRequest, successStatusCodes: Set<Int>)] = []
    public var performHTTPRequestUrlRequestSuccessStatusCodesReturnValue: HTTPServiceResult!
    public var performHTTPRequestUrlRequestSuccessStatusCodesClosure: ((URLRequest, Set<Int>) async -> HTTPServiceResult)?

    public func performHTTPRequest(urlRequest: URLRequest, successStatusCodes: Set<Int>) async -> HTTPServiceResult {
        performHTTPRequestUrlRequestSuccessStatusCodesCallsCount += 1
        performHTTPRequestUrlRequestSuccessStatusCodesReceivedArguments = (urlRequest: urlRequest, successStatusCodes: successStatusCodes)
        performHTTPRequestUrlRequestSuccessStatusCodesReceivedInvocations.append((urlRequest: urlRequest, successStatusCodes: successStatusCodes))
        if let performHTTPRequestUrlRequestSuccessStatusCodesClosure = performHTTPRequestUrlRequestSuccessStatusCodesClosure {
            return await performHTTPRequestUrlRequestSuccessStatusCodesClosure(urlRequest, successStatusCodes)
        } else {
            return performHTTPRequestUrlRequestSuccessStatusCodesReturnValue
        }
    }

}
public class LocationDelegateHandlerProtocolMock: LocationDelegateHandlerProtocol {

    public init() {}


    //MARK: - resultForDidUpdateLocations

    public var resultForDidUpdateLocationsDateManagerInitializedCallsCount = 0
    public var resultForDidUpdateLocationsDateManagerInitializedCalled: Bool {
        return resultForDidUpdateLocationsDateManagerInitializedCallsCount > 0
    }
    public var resultForDidUpdateLocationsDateManagerInitializedReceivedArguments: (locations: [CLLocationProtocol], dateManagerInitialized: Date)?
    public var resultForDidUpdateLocationsDateManagerInitializedReceivedInvocations: [(locations: [CLLocationProtocol], dateManagerInitialized: Date)] = []
    public var resultForDidUpdateLocationsDateManagerInitializedReturnValue: LocationRequestResult?
    public var resultForDidUpdateLocationsDateManagerInitializedClosure: (([CLLocationProtocol], Date) -> LocationRequestResult?)?

    public func resultForDidUpdateLocations(_ locations: [CLLocationProtocol], dateManagerInitialized: Date) -> LocationRequestResult? {
        resultForDidUpdateLocationsDateManagerInitializedCallsCount += 1
        resultForDidUpdateLocationsDateManagerInitializedReceivedArguments = (locations: locations, dateManagerInitialized: dateManagerInitialized)
        resultForDidUpdateLocationsDateManagerInitializedReceivedInvocations.append((locations: locations, dateManagerInitialized: dateManagerInitialized))
        if let resultForDidUpdateLocationsDateManagerInitializedClosure = resultForDidUpdateLocationsDateManagerInitializedClosure {
            return resultForDidUpdateLocationsDateManagerInitializedClosure(locations, dateManagerInitialized)
        } else {
            return resultForDidUpdateLocationsDateManagerInitializedReturnValue
        }
    }

    //MARK: - resultForDidFailWithError

    public var resultForDidFailWithErrorCallsCount = 0
    public var resultForDidFailWithErrorCalled: Bool {
        return resultForDidFailWithErrorCallsCount > 0
    }
    public var resultForDidFailWithErrorReceivedError: Error?
    public var resultForDidFailWithErrorReceivedInvocations: [Error] = []
    public var resultForDidFailWithErrorReturnValue: LocationRequestResult?
    public var resultForDidFailWithErrorClosure: ((Error) -> LocationRequestResult?)?

    public func resultForDidFailWithError(_ error: Error) -> LocationRequestResult? {
        resultForDidFailWithErrorCallsCount += 1
        resultForDidFailWithErrorReceivedError = error
        resultForDidFailWithErrorReceivedInvocations.append(error)
        if let resultForDidFailWithErrorClosure = resultForDidFailWithErrorClosure {
            return resultForDidFailWithErrorClosure(error)
        } else {
            return resultForDidFailWithErrorReturnValue
        }
    }

}
public class LocationRequestHandlerProtocolMock: LocationRequestHandlerProtocol {

    public init() {}


    //MARK: - requestLocation

    public var requestLocationCallsCount = 0
    public var requestLocationCalled: Bool {
        return requestLocationCallsCount > 0
    }
    public var requestLocationReceivedCallback: ((LocationRequestResult) -> Void)?
    public var requestLocationReceivedInvocations: [((LocationRequestResult) -> Void)] = []
    public var requestLocationClosure: ((@escaping (LocationRequestResult) -> Void) -> Void)?

    public func requestLocation(_ callback: @escaping (LocationRequestResult) -> Void) {
        requestLocationCallsCount += 1
        requestLocationReceivedCallback = callback
        requestLocationReceivedInvocations.append(callback)
        requestLocationClosure?(callback)
    }

}
public class UIWindowProtocolMock: UIWindowProtocol {

    public init() {}

    public var rootViewController: UIViewController?

    //MARK: - makeKeyAndVisible

    public var makeKeyAndVisibleCallsCount = 0
    public var makeKeyAndVisibleCalled: Bool {
        return makeKeyAndVisibleCallsCount > 0
    }
    public var makeKeyAndVisibleClosure: (() -> Void)?

    public func makeKeyAndVisible() {
        makeKeyAndVisibleCallsCount += 1
        makeKeyAndVisibleClosure?()
    }

}
public class URLOpenerServiceProtocolMock: URLOpenerServiceProtocol {

    public init() {}

    public var openSettingsBlock: OpenURLBlock?

    //MARK: - buildOpenURLBlock

    public var buildOpenURLBlockCallsCount = 0
    public var buildOpenURLBlockCalled: Bool {
        return buildOpenURLBlockCallsCount > 0
    }
    public var buildOpenURLBlockReceivedUrl: URL?
    public var buildOpenURLBlockReceivedInvocations: [URL] = []
    public var buildOpenURLBlockReturnValue: OpenURLBlock?
    public var buildOpenURLBlockClosure: ((URL) -> OpenURLBlock?)?

    public func buildOpenURLBlock(_ url: URL) -> OpenURLBlock? {
        buildOpenURLBlockCallsCount += 1
        buildOpenURLBlockReceivedUrl = url
        buildOpenURLBlockReceivedInvocations.append(url)
        if let buildOpenURLBlockClosure = buildOpenURLBlockClosure {
            return buildOpenURLBlockClosure(url)
        } else {
            return buildOpenURLBlockReturnValue
        }
    }

    //MARK: - buildPhoneCallBlock

    public var buildPhoneCallBlockCallsCount = 0
    public var buildPhoneCallBlockCalled: Bool {
        return buildPhoneCallBlockCallsCount > 0
    }
    public var buildPhoneCallBlockReceivedPhoneNumber: NonEmptyString?
    public var buildPhoneCallBlockReceivedInvocations: [NonEmptyString] = []
    public var buildPhoneCallBlockReturnValue: OpenURLBlock?
    public var buildPhoneCallBlockClosure: ((NonEmptyString) -> OpenURLBlock?)?

    public func buildPhoneCallBlock(_ phoneNumber: NonEmptyString) -> OpenURLBlock? {
        buildPhoneCallBlockCallsCount += 1
        buildPhoneCallBlockReceivedPhoneNumber = phoneNumber
        buildPhoneCallBlockReceivedInvocations.append(phoneNumber)
        if let buildPhoneCallBlockClosure = buildPhoneCallBlockClosure {
            return buildPhoneCallBlockClosure(phoneNumber)
        } else {
            return buildPhoneCallBlockReturnValue
        }
    }

}
public class URLSessionProtocolMock: URLSessionProtocol, @unchecked Sendable {

    public init() {}


    //MARK: - data

    public var dataForThrowableError: Error?
    public var dataForCallsCount = 0
    public var dataForCalled: Bool {
        return dataForCallsCount > 0
    }
    public var dataForReceivedRequest: URLRequest?
    public var dataForReceivedInvocations: [URLRequest] = []
    public var dataForReturnValue: (Data, URLResponse)!
    public var dataForClosure: ((URLRequest) async throws -> (Data, URLResponse))?

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataForCallsCount += 1
        if let error = dataForThrowableError {
            throw error
        }
        dataForReceivedRequest = request
        dataForReceivedInvocations.append(request)
        if let dataForClosure = dataForClosure {
            return try await dataForClosure(request)
        } else {
            return dataForReturnValue
        }
    }

}
