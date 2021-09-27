// Generated using Sourcery 1.2.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


















import CoreLocation
import Foundation
import Shared

open class CLLocationManagerAuthProtocolMock: CLLocationManagerAuthProtocol {
    open var delegate: CLLocationManagerDelegate?

    public init() {}

    // MARK: - requestWhenInUseAuthorization

    open var requestWhenInUseAuthorizationCallsCount = 0
    open var requestWhenInUseAuthorizationCalled: Bool {
        return requestWhenInUseAuthorizationCallsCount > 0
    }
    open var requestWhenInUseAuthorizationClosure: (() -> Void)?

    open func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationCallsCount += 1
        requestWhenInUseAuthorizationClosure?()
    }

}
open class CLLocationManagerRequestProtocolMock: CLLocationManagerRequestProtocol {
    open var delegate: CLLocationManagerDelegate?

    public init() {}

    // MARK: - startUpdatingLocation

    open var startUpdatingLocationCallsCount = 0
    open var startUpdatingLocationCalled: Bool {
        return startUpdatingLocationCallsCount > 0
    }
    open var startUpdatingLocationClosure: (() -> Void)?

    open func startUpdatingLocation() {
        startUpdatingLocationCallsCount += 1
        startUpdatingLocationClosure?()
    }

    // MARK: - stopUpdatingLocation

    open var stopUpdatingLocationCallsCount = 0
    open var stopUpdatingLocationCalled: Bool {
        return stopUpdatingLocationCallsCount > 0
    }
    open var stopUpdatingLocationClosure: (() -> Void)?

    open func stopUpdatingLocation() {
        stopUpdatingLocationCallsCount += 1
        stopUpdatingLocationClosure?()
    }

}
open class HTTPServiceProtocolMock: HTTPServiceProtocol {

    public init() {}

    // MARK: - performHTTPRequest

    open var performHTTPRequestSuccessStatusCodesCompletionCallsCount = 0
    open var performHTTPRequestSuccessStatusCodesCompletionCalled: Bool {
        return performHTTPRequestSuccessStatusCodesCompletionCallsCount > 0
    }
    open var performHTTPRequestSuccessStatusCodesCompletionReceivedArguments: (urlRequest: URLRequest, successStatusCodes: Set<Int>, completion: HTTPServiceCompletion)?
    open var performHTTPRequestSuccessStatusCodesCompletionClosure: ((URLRequest, Set<Int>, @escaping HTTPServiceCompletion) -> Void)?

    open func performHTTPRequest(_ urlRequest: URLRequest,
                            successStatusCodes: Set<Int>,
                            completion: @escaping HTTPServiceCompletion) {
        performHTTPRequestSuccessStatusCodesCompletionCallsCount += 1
        performHTTPRequestSuccessStatusCodesCompletionReceivedArguments = (urlRequest: urlRequest, successStatusCodes: successStatusCodes, completion: completion)
        performHTTPRequestSuccessStatusCodesCompletionClosure?(urlRequest, successStatusCodes, completion)
    }

}
open class LocationDelegateHandlerProtocolMock: LocationDelegateHandlerProtocol {

    public init() {}

    // MARK: - resultForDidUpdateLocations

    open var resultForDidUpdateLocationsDateManagerInitializedCallsCount = 0
    open var resultForDidUpdateLocationsDateManagerInitializedCalled: Bool {
        return resultForDidUpdateLocationsDateManagerInitializedCallsCount > 0
    }
    open var resultForDidUpdateLocationsDateManagerInitializedReceivedArguments: (locations: [CLLocationProtocol], dateManagerInitialized: Date)?
    open var resultForDidUpdateLocationsDateManagerInitializedReturnValue: LocationRequestResult?
    open var resultForDidUpdateLocationsDateManagerInitializedClosure: (([CLLocationProtocol], Date) -> LocationRequestResult?)?

    open func resultForDidUpdateLocations(_ locations: [CLLocationProtocol],
                                     dateManagerInitialized: Date) -> LocationRequestResult? {
        resultForDidUpdateLocationsDateManagerInitializedCallsCount += 1
        resultForDidUpdateLocationsDateManagerInitializedReceivedArguments = (locations: locations, dateManagerInitialized: dateManagerInitialized)
        return resultForDidUpdateLocationsDateManagerInitializedClosure.map({ $0(locations, dateManagerInitialized) }) ?? resultForDidUpdateLocationsDateManagerInitializedReturnValue
    }

    // MARK: - resultForDidFailWithError

    open var resultForDidFailWithErrorCallsCount = 0
    open var resultForDidFailWithErrorCalled: Bool {
        return resultForDidFailWithErrorCallsCount > 0
    }
    open var resultForDidFailWithErrorReceivedError: Error?
    open var resultForDidFailWithErrorReturnValue: LocationRequestResult?
    open var resultForDidFailWithErrorClosure: ((Error) -> LocationRequestResult?)?

    open func resultForDidFailWithError(_ error: Error) -> LocationRequestResult? {
        resultForDidFailWithErrorCallsCount += 1
        resultForDidFailWithErrorReceivedError = error
        return resultForDidFailWithErrorClosure.map({ $0(error) }) ?? resultForDidFailWithErrorReturnValue
    }

}
open class LocationRequestHandlerProtocolMock: LocationRequestHandlerProtocol {

    public init() {}

    // MARK: - requestLocation

    open var requestLocationCallsCount = 0
    open var requestLocationCalled: Bool {
        return requestLocationCallsCount > 0
    }
    open var requestLocationReceivedCallback: ((LocationRequestResult) -> Void)?
    open var requestLocationClosure: ((@escaping (LocationRequestResult) -> Void) -> Void)?

    open func requestLocation(_ callback: @escaping (LocationRequestResult) -> Void) {
        requestLocationCallsCount += 1
        requestLocationReceivedCallback = callback
        requestLocationClosure?(callback)
    }

}
open class NetworkDataServiceProtocolMock: NetworkDataServiceProtocol {

    public init() {}

    // MARK: - performDataTask

    open var performDataTaskCompletionCallsCount = 0
    open var performDataTaskCompletionCalled: Bool {
        return performDataTaskCompletionCallsCount > 0
    }
    open var performDataTaskCompletionReceivedArguments: (urlRequest: URLRequest, completion: NetworkDataServiceCompletion)?
    open var performDataTaskCompletionClosure: ((URLRequest, @escaping NetworkDataServiceCompletion) -> Void)?

    open func performDataTask(_ urlRequest: URLRequest,
                         completion: @escaping NetworkDataServiceCompletion) {
        performDataTaskCompletionCallsCount += 1
        performDataTaskCompletionReceivedArguments = (urlRequest: urlRequest, completion: completion)
        performDataTaskCompletionClosure?(urlRequest, completion)
    }

}
open class UIWindowProtocolMock: UIWindowProtocol {
    open var rootViewController: UIViewController?

    public init() {}

    // MARK: - makeKeyAndVisible

    open var makeKeyAndVisibleCallsCount = 0
    open var makeKeyAndVisibleCalled: Bool {
        return makeKeyAndVisibleCallsCount > 0
    }
    open var makeKeyAndVisibleClosure: (() -> Void)?

    open func makeKeyAndVisible() {
        makeKeyAndVisibleCallsCount += 1
        makeKeyAndVisibleClosure?()
    }

}
open class URLOpenerServiceProtocolMock: URLOpenerServiceProtocol {
    open var openSettingsBlock: OpenURLBlock?

    public init() {}

    // MARK: - buildOpenURLBlock

    open var buildOpenURLBlockCallsCount = 0
    open var buildOpenURLBlockCalled: Bool {
        return buildOpenURLBlockCallsCount > 0
    }
    open var buildOpenURLBlockReceivedUrl: URL?
    open var buildOpenURLBlockReturnValue: OpenURLBlock?
    open var buildOpenURLBlockClosure: ((URL) -> OpenURLBlock?)?

    open func buildOpenURLBlock(_ url: URL) -> OpenURLBlock? {
        buildOpenURLBlockCallsCount += 1
        buildOpenURLBlockReceivedUrl = url
        return buildOpenURLBlockClosure.map({ $0(url) }) ?? buildOpenURLBlockReturnValue
    }

    // MARK: - buildPhoneCallBlock

    open var buildPhoneCallBlockCallsCount = 0
    open var buildPhoneCallBlockCalled: Bool {
        return buildPhoneCallBlockCallsCount > 0
    }
    open var buildPhoneCallBlockReceivedPhoneNumber: NonEmptyString?
    open var buildPhoneCallBlockReturnValue: OpenURLBlock?
    open var buildPhoneCallBlockClosure: ((NonEmptyString) -> OpenURLBlock?)?

    open func buildPhoneCallBlock(_ phoneNumber: NonEmptyString) -> OpenURLBlock? {
        buildPhoneCallBlockCallsCount += 1
        buildPhoneCallBlockReceivedPhoneNumber = phoneNumber
        return buildPhoneCallBlockClosure.map({ $0(phoneNumber) }) ?? buildPhoneCallBlockReturnValue
    }

}
open class URLSessionDataTaskProtocolMock: URLSessionDataTaskProtocol {

    public init() {}

    // MARK: - resume

    open var resumeCallsCount = 0
    open var resumeCalled: Bool {
        return resumeCallsCount > 0
    }
    open var resumeClosure: (() -> Void)?

    open func resume() {
        resumeCallsCount += 1
        resumeClosure?()
    }

}
open class URLSessionProtocolMock<TSessionDataTask: URLSessionDataTaskProtocol>: URLSessionProtocol {

    public init() {}

    // MARK: - dataTask

    open var dataTaskWithCompletionHandlerCallsCount = 0
    open var dataTaskWithCompletionHandlerCalled: Bool {
        return dataTaskWithCompletionHandlerCallsCount > 0
    }
    open var dataTaskWithCompletionHandlerReceivedArguments: (request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
    open var dataTaskWithCompletionHandlerReturnValue: TSessionDataTask!
    open var dataTaskWithCompletionHandlerClosure: ((URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> TSessionDataTask)?

    open func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TSessionDataTask {
        dataTaskWithCompletionHandlerCallsCount += 1
        dataTaskWithCompletionHandlerReceivedArguments = (request: request, completionHandler: completionHandler)
        return dataTaskWithCompletionHandlerClosure.map({ $0(request, completionHandler) }) ?? dataTaskWithCompletionHandlerReturnValue
    }

}
