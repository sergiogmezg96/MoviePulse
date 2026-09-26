//  MPUseCase.swift
//  MPLibrary
//
//  Created by Sergio Gómez García on 22/09/2026.
//

import Foundation

public protocol MPUseCase {
    associatedtype Input = Void
    associatedtype Output = Void
    
    func execute(request: Input) async throws -> Output
}

public extension MPUseCase where Input == Void {
    func execute() async throws -> Output {
        try await execute(request: ())
    }
}
