//
//  URLOpenerService.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

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
