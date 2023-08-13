//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

protocol ComponentRepository {
    func getComponent(componentName: String, preloadAllowed: Bool, branchName: String?) async throws -> GetComponentResponse
    func sendConversionEvent(eventID: ID, abTestID: ID?) throws -> Void
}

