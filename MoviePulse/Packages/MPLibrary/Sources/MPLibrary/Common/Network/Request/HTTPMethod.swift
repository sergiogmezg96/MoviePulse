//
//  HTTPMethod.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case put
    
    public var value: String {
        switch self {
            case .get: "GET"
            case .post: "POST"
            case .put: "PUT"
        }
    }
}
