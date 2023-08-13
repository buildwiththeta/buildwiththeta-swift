//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

struct GetComponentUseCase {
    private let componentRepository: ComponentRepository

    init(componentRepository: ComponentRepository) {
        self.componentRepository = componentRepository
    }

    func call(params: GetComponentUseCaseParams) async throws -> GetComponentResponse {
        return try await componentRepository.getComponent(
            componentName: params.componentName,
            preloadAllowed: params.preloadAllowed,
            branchName: params.branchName
        )
    }
}

struct GetComponentUseCaseParams {
    let componentName: String
    let branchName: String?
    let preloadAllowed: Bool
}
