//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import SwiftUI

struct LocalNotifier<Content: View>: View {
    @EnvironmentObject var treeState: TreeState
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        content().environmentObject(treeState.copyWith())
    }
}
