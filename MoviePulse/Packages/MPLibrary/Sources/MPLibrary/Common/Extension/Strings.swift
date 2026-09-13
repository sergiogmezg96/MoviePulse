//
//  Strings.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 09/09/2026.
//

import Foundation

public extension String {
    var localized: String { NSLocalizedString(self, bundle: .main, comment: "") }
}
