//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

struct ComponentRepositoryImpl: ComponentRepository {
    
    let preloadFile: PreloadFile
    let componentService: ComponentService
    let isCacheEnabled: Bool
    
    init(preloadFile: PreloadFile, componentService: ComponentService, isCacheEnabled: Bool) {
        self.preloadFile = preloadFile
        self.componentService = componentService
        self.isCacheEnabled = isCacheEnabled
    }
    
    private func get(_ componentName: String, _ branchName: String?) async throws -> GetComponentResponse {
        return try componentService.getComponent(componentName: componentName, branchName: branchName)
    }

    func getComponent(componentName: String, preloadAllowed: Bool, branchName: String?) async throws -> GetComponentResponse {
        do {
            let res = try await get(componentName, branchName)
            return res
        } catch {
            print("Error fetching component: \(error)")
            let res = try? await get(componentName, branchName)
            return res!
        }
    }
    
    func sendConversionEvent(eventID: ID, abTestID: ID?) throws -> Void {
        return
    }
}
