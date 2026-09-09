//
//  ApiRequest.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public struct ApiRequest {
    let url: Endpoint
    var method: HTTPMethod = .get
    var headers: [String: String]?
    var body: Data?
    var contentType: String
    
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
