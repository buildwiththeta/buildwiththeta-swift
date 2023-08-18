//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

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
        GeometryReader { proxy in
            content
                .environmentObject(treeState)
                .environment(\.mainWindowSize, proxy.size)
        }
    }
}

struct ThetaProviderPreview: PreviewProvider {
    static var previews: some View {
        ThetaProvider(theme: ThemeMode.dark, content: {
            Text("Ciao 2").foregroundColor(Color(hex: "000000"))
        })
    }
}
