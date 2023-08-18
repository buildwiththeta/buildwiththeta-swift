//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

struct Client {
    let getComponentUseCase: GetComponentUseCase
    let getStylesUseCase: GetStylesUseCase
    
    func initialize(preloadAllowed: Bool) async throws -> Void {
        try await getStyles(preloadAllowed: preloadAllowed)
    }
    
    func getStyles(preloadAllowed: Bool) async throws -> GetStylesResponse {
        return try await getStylesUseCase.call(params: GetStylesUseCaseParams(preloadAllowed: preloadAllowed))
    }
    
    func build(componentName: String, branchName: String?, preloadAllowed: Bool) async throws -> GetComponentResponse {
        return try await getComponentUseCase.call(params: GetComponentUseCaseParams(componentName: componentName, branchName: branchName, preloadAllowed: preloadAllowed))
    }
}
