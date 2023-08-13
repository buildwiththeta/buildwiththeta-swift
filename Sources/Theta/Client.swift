//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

struct Client {
    let getComponentUseCase: GetComponentUseCase
    
    func initialize() async throws -> Void {
        
    }
    
    func build(componentName: String, branchName: String?, preloadAllowed: Bool) async throws -> GetComponentResponse {
        return try await getComponentUseCase.call(params: GetComponentUseCaseParams(componentName: componentName, branchName: branchName, preloadAllowed: preloadAllowed))
    }
}
