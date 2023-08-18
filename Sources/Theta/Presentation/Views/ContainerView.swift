//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 29/07/23.
//

import Foundation
import SwiftUI

struct ContainerView: View {
    var child: AnyView?
    var width: FSize
    var height: FSize
    var padding: FMargins
    var fillColor: FFill
    var borderRadius: FBorderRadius
    // Missing borders and shadows
    
    @Environment(\.mainWindowSize) var mainWindowSize

    var body: some View {
        if child == nil {
            Rectangle()
        }
        child
            .frame(
                width: CGFloat(
                    width.get(
                        device: DeviceType.mobile,
                        isWidth: true,
                        screenSize: mainWindowSize
                    )!
                ),
                height: CGFloat(
                    height.get(
                        device: DeviceType.mobile,
                        isWidth: false,
                        screenSize: mainWindowSize
                    )!
                )
            )
            .padding(padding.get(device: DeviceType.mobile))
            .background(
                borderRadius
                    .get()
                    .fill(fillColor.getHexColor())
            )
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(child: AnyView(Text("Hello")), width: FSize(mobile: "150", tablet: "150", desktop: "150"), height: FSize(mobile: "150", tablet: "150", desktop: "150"), padding: FMargins(mobile: [0,0,0,0], tablet: [0,0,0,0], desktop: [0,0,0,0]), fillColor: FFill(levels: [FFillElement(color: "a8be12", opacity: 1, stop: 0)], type: FFillType.solid, begin: nil, end: nil, center: nil, radius: nil, boxFit: nil, paletteStyle: nil), borderRadius: FBorderRadius(mobile: [0,0,0,0], tablet: [0,0,0,0], desktop: [0,0,0,0]))
    }
}
