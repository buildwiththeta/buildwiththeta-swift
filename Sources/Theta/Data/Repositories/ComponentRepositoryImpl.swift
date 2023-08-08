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
    let localComponentService: LocalComponentService
    let isCacheEnabled: Bool
    
    init(preloadFile: PreloadFile, componentService: ComponentService, localComponentService: LocalComponentService, isCacheEnabled: Bool) {
        self.preloadFile = preloadFile
        self.componentService = componentService
        self.localComponentService = localComponentService
        self.isCacheEnabled = isCacheEnabled
    }
    
    private func get(_ componentName: String, _ branchName: String?) throws -> GetComponentResponse {
        do {
            return componentService.getComponent(componentName: componentName, branchName: branchName)
        }
    }

    private func getPreloaded(_ componentName: String, _ branchName: String?) throws -> Either<Error, GetComponentResponse> {
        do {
            return .right(try localComponentService.getPreloadedComponent(componentName))
        } catch {
            return .left(error)
        }
    }

    private func getCached(_ componentName: String, _ branchName: String?) throws -> Either<Error, GetComponentResponse> {
        if let cachedComponent = try? localComponentService.getLocalComponent(componentName, branchName) {
            return .right(cachedComponent)
        }

        let res = try? get(componentName, branchName)
        try? localComponentService.saveResponse(componentName, branchName, res)
        return .right(res!)
    }
    
    func getComponent(componentName: String, preloadAllowed: Bool, branchName: String?) throws-> Either<Error, GetComponentResponse> {
        do {
            if preloadFile.enabled && preloadAllowed {
                return try getPreloaded(componentName, branchName)
            }

            if !isCacheEnabled {
                let res = try get(componentName, branchName)
                return .right(res)
            }

            return try getCached(componentName, branchName)
        } catch {
            print("Error fetching component: \(error)")

            try? localComponentService.clearCache()
            let res = try? get(componentName, branchName)
            return .right(res!)
        }
    }
    
    func sendConversionEvent(eventID: ID, abTestID: ID?) -> Either<Error, Void> {
        do {
            
        } catch (e) {
            
        }
    }
}
