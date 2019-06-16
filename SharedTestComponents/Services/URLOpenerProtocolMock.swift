//
//  URLOpenerProtocolMock.swift
//  SharedTestComponents
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation
import Shared

// swiftlint:disable identifier_name
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable large_tuple
open class URLOpenerProtocolMock: URLOpenerProtocol {
    public static var openSettingsURLString: String {
        get { return underlyingOpenSettingsURLString }
        set(value) { underlyingOpenSettingsURLString = value }
    }
    public static var underlyingOpenSettingsURLString: String!

    public init() {}

    // MARK: - open

    open var openOptionsCompletionHandlerCallsCount = 0
    open var openOptionsCompletionHandlerCalled: Bool {
        return openOptionsCompletionHandlerCallsCount > 0
    }
    open var openOptionsCompletionHandlerReceivedArguments: (
        url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any],
        completion: ((Bool) -> Void)?
    )?
    open var openOptionsCompletionHandlerClosure: (
        (URL, [UIApplication.OpenExternalURLOptionsKey: Any], ((Bool) -> Void)?) -> Void
    )?

    open func open(_ url: URL,
                   options: [UIApplication.OpenExternalURLOptionsKey: Any],
                   completionHandler completion: ((Bool) -> Void)?) {
        openOptionsCompletionHandlerCallsCount += 1
        openOptionsCompletionHandlerReceivedArguments = (url: url, options: options, completion: completion)
        openOptionsCompletionHandlerClosure?(url, options, completion)
    }

    // MARK: - canOpenURL

    open var canOpenURLCallsCount = 0
    open var canOpenURLCalled: Bool {
        return canOpenURLCallsCount > 0
    }
    open var canOpenURLReceivedUrl: URL?
    open var canOpenURLReturnValue: Bool!
    open var canOpenURLClosure: ((URL) -> Bool)?

    open func canOpenURL(_ url: URL) -> Bool {
        canOpenURLCallsCount += 1
        canOpenURLReceivedUrl = url
        return canOpenURLClosure.map { $0(url) } ?? canOpenURLReturnValue
    }

}
