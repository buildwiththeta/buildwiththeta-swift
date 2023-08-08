//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

protocol ComponentRepository {
    func getComponent(componentName: String, preloadAllowed: Bool, branchName: String?) -> Either<Error, GetComponentResponse>
    func sendConversionEvent(eventID: ID, abTestID: ID?) -> Either<Error, Void>
}

