//
//  Endpoint.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    public init(
        path: String,
        queryItems: [URLQueryItem] = []
    ) {
        self.path = path
        self.queryItems = queryItems
    }
}
