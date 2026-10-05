//
//  ApiRequest.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public struct ApiRequest {
    public let url: Endpoint
    public var method: HTTPMethod = .get
    public var headers: [String: String]?
    public var body: Data?
    public var contentType: String
    
    public init(
        url: Endpoint,
        method: HTTPMethod,
        headers: [String : String]? = nil,
        body: Data? = nil,
        contentType: String = "application/json"
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.contentType = contentType
    }
}
