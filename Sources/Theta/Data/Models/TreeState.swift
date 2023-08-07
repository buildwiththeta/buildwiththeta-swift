//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

class TreeState: ObservableObject {
    @Published var theme: ThemeMode
    @Published var colorStyles: [ColorStyle]
    @Published var textStyles: [TextStyle]
    @Published var preloaded: Bool
    
    init(theme: ThemeMode = ThemeMode.light, colorStyles: [ColorStyle] = [], textStyles: [TextStyle] = [], preloaded: Bool = false) {
        self.theme = theme
        self.colorStyles = colorStyles
        self.textStyles = textStyles
        self.preloaded = preloaded
    }
    
    func copyWith(theme: ThemeMode? = nil, colorStyles: [ColorStyle]? = nil, textStyles: [TextStyle]? = nil) -> TreeState {
        return TreeState(theme: theme ?? self.theme, colorStyles: colorStyles ?? self.colorStyles, textStyles: textStyles ?? self.textStyles)
    }
}
