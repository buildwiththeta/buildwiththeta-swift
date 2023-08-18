//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 13/08/23.
//

import Foundation

struct StylesRepositoryImpl: StylesRepository {
    let preloadFile: PreloadFile
    let stylesService: StylesService
    
    init(stylesService: StylesService, preloadFile: PreloadFile) {
        self.stylesService = stylesService
        self.preloadFile = preloadFile
    }
    
    func getStyles(preloadAllowed: Bool) async throws -> GetStylesResponse {
        do {
            let res = try stylesService.fetch()
            return res
        } catch {
            throw RuntimeError("Error fetching styles")
        }
    }
}
