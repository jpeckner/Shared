//
//  URLOpenerProtocolMock.swift
//  SharedTestComponents
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
