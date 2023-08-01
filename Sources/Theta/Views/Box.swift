//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 29/07/23.
//

import Foundation
import SwiftUI

struct WContainer : View {
    var body: some View {
        Rectangle()
        .frame(
            width: 300,
            height: 300
        )
        .background(Color.black)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        WContainer()
    }
}
