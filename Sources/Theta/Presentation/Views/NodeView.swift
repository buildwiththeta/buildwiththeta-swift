//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 06/08/23.
//

import Foundation
import SwiftUI

struct NodeView: View {
    let node: CNode
    
    var body: some View {
        switch (node.type) {
        case "column":
            ColumnView(mainAxisAlignment: node.attributes.mainAxisAlignment!, crossAxisAlignment: node.attributes.crossAxisAlignment!, children: node.children)
        default:
            Text(node.type)
        }
    }
}
