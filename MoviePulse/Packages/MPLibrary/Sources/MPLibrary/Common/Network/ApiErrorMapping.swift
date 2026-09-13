//
//  ApiErrorMapping.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public struct ApiErrorMapping {
    public static func message(for error: ApiError) -> String {
        switch error {
        case .networkError:
            return "api_error_network".localized

        case .invalidResponse:
            return "api_error_invalid_response".localized

        case .dataParsingError:
            return "api_error_data_parsing".localized

        case .unauthorized:
            return "api_error_unauthorized".localized

        case .forbidden:
            return "api_error_forbidden".localized

        case .serviceUnavailable:
            return "api_error_service_unavailable".localized

        case .serverError:
            return "api_error_server".localized

        case .malformedURL:
            return "api_error_malformed_url".localized

        case .unknownError:
            return "api_error_unknown".localized
        }
    }
}
