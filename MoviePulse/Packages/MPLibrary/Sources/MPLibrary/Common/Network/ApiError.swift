//
//  ApiError.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public enum ApiError: Error {
    case networkError(description: String)
    case invalidResponse
    case dataParsingError
    case unauthorized
    case forbidden
    case serviceUnavailable
    case serverError(statusCode: Int)
    case malformedURL
    case unknownError
}
