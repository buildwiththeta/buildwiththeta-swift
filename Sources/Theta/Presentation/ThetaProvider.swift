//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import SwiftUI

struct ThetaProvider<Content: View>: View {
    var theme: ThemeMode
    @StateObject var treeState: TreeState = TreeState(theme: ThemeMode.light, colorStyles: [], textStyles: [])
    @ViewBuilder let content: Content
    
    init(theme: ThemeMode, content: () -> Content) {
        self.theme = theme
        self.content = content()
        
        self.treeState.theme = theme
    }
    
    var body: some View {
        content.environmentObject(treeState)
    }
}

struct ThetaProviderPreview: PreviewProvider {
    static var previews: some View {
        ThetaProvider(theme: ThemeMode.dark, content: {
            Text("Ciao 2").foregroundColor(Color(hex: "000000"))
        })
    }
}
