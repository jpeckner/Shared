//
//  URLOpenerService.swift
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

import Foundation
import UIKit

public typealias OpenURLBlock = () -> Void

public protocol URLOpenerProtocol: AnyObject {
    static var openSettingsURLString: String { get }

    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completionHandler completion: ((Bool) -> Void)?)

    func canOpenURL(_ url: URL) -> Bool
}

extension UIApplication: URLOpenerProtocol {}

private extension URLOpenerProtocol {

    func openURLBlock(
        url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
        completion: ((Bool) -> Void)? = nil
    ) -> OpenURLBlock? {
        return canOpenURL(url) ? { [weak self] in
            self?.open(url,
                       options: options,
                       completionHandler: completion)
        }
        : nil
    }

}

// MARK: URLOpenerService

public protocol URLOpenerServiceProtocol: AutoMockable {
    var openSettingsBlock: OpenURLBlock? { get }

    func buildOpenURLBlock(_ url: URL) -> OpenURLBlock?
    func buildPhoneCallBlock(_ phoneNumber: NonEmptyString) -> OpenURLBlock?
}

public class URLOpenerService: URLOpenerServiceProtocol {

    private let urlOpener: URLOpenerProtocol
    public let openSettingsBlock: OpenURLBlock?

    public init(urlOpener: URLOpenerProtocol) {
        self.urlOpener = urlOpener

        let openSettingsURL = URL(string: type(of: urlOpener).openSettingsURLString)
        self.openSettingsBlock = openSettingsURL.flatMap { urlOpener.openURLBlock(url: $0) }
    }

    public func buildOpenURLBlock(_ url: URL) -> OpenURLBlock? {
        return urlOpener.openURLBlock(url: url)
    }

    public func buildPhoneCallBlock(_ phoneNumber: NonEmptyString) -> OpenURLBlock? {
        guard let url = URL(string: "tel:\(phoneNumber.value)") else { return nil }

        return urlOpener.openURLBlock(url: url)
    }

}
