//
//  URLComponents+Query.swift
//  Shared
//
//  Created by Justin Peckner.
//  Copyright © 2019 Justin Peckner. All rights reserved.
//

import Foundation

public extension URLComponents {

    func queryItem(for paramName: String) -> URLQueryItem? {
        return queryItems?.first { $0.name == paramName }
    }

}
