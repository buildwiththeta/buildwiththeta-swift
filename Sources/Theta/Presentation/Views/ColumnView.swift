//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 06/08/23.
//

import Foundation
import SwiftUI

struct ColumnView: View {
    let mainAxisAlignment: MainAxisAlignment
    let crossAxisAlignment: CrossAxisAlignment
    let children: [CNode]
    
    var body: some View {
        CrossAlignView(mainAxisAlignment: mainAxisAlignment, crossAxisAlignment: crossAxisAlignment, children: children)
    }
}

private struct CrossAlignView: View {
    let mainAxisAlignment: MainAxisAlignment
    let crossAxisAlignment: CrossAxisAlignment
    let children: [CNode]

    var body: some View {
        switch (crossAxisAlignment) {
        case .start:
            HStack {
                MainAxisView(mainAxisAlignment: mainAxisAlignment, children: children)
                Spacer()
            }
        case .center:
            HStack {
                Spacer()
                MainAxisView(mainAxisAlignment: mainAxisAlignment, children: children)
                Spacer()
            }
        case .end:
            HStack {
                Spacer()
                MainAxisView(mainAxisAlignment: mainAxisAlignment, children: children)
            }
        case .stretch:
            MainAxisView(
                mainAxisAlignment: mainAxisAlignment, children: children)
        }
    }
}

private struct MainAxisView: View {
    let mainAxisAlignment: MainAxisAlignment
    let children: [CNode]
    
    var body: some View {
        switch (mainAxisAlignment) {
        case .start:
             StartAligned(children: children)
        case .center:
             CenterAligned(children: children)
        case .end:
             EndAligned(children: children)
        case .spaceBetween:
             SpaceBetweenAligned(children: children)
        case .spaceAround:
             SpaceAroundAligned(children: children)
        }
    }
}

private struct StartAligned: View {
    let children: [CNode]

    var body: some View {
        VStack {
            ForEach(children, id: \.self.id) { node in
                NodeView(node: node)
            }
            Spacer()
        }
    }
}

private struct CenterAligned: View {
    let children: [CNode]

    var body: some View {
        VStack {
            Spacer()
            ForEach(children, id: \.self.id) { node in
                NodeView(node: node)
            }
            Spacer()
        }
    }
}

private struct EndAligned: View {
    let children: [CNode]

    var body: some View {
        VStack {
            Spacer()
            ForEach(children, id: \.self.id) { node in
                NodeView(node: node)
            }
        }
    }
}

private struct SpaceBetweenAligned: View {
    let children: [CNode]

    var body: some View {
        VStack {
           ForEach(children, id: \.self.id) { node in
               let index = children.firstIndex(of: node)
               
               NodeView(node: node)
               if (index != children.count - 1) {
                   Spacer()
               }
           }
       }
    }
}

private struct SpaceAroundAligned: View {
    let children: [CNode]

    var body: some View {
        VStack {
           Spacer()
           ForEach(children, id: \.self.id) { node in
               NodeView(node: node)
               Spacer()
           }
       }
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        ColumnView(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
       ])
    }
}
