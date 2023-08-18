//
//  File.swift
//
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

struct GetStylesUseCase {
    private let stylesRepository: StylesRepository

    init(stylesRepository: StylesRepository) {
        self.stylesRepository = stylesRepository
    }

    func call(params: GetStylesUseCaseParams) async throws -> GetStylesResponse {
        return try await stylesRepository.getStyles(
            preloadAllowed: params.preloadAllowed
        )
    }
}

struct GetStylesUseCaseParams {
    let preloadAllowed: Bool
}

