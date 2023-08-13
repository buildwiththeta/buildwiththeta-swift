//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

protocol StylesRepository {
    func getStyles(preloadAllowed: Bool) async throws -> GetStylesResponse
}
