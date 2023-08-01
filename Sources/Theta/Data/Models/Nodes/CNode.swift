//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

protocol CNode {
    var id: String { get set }
    var type: String { get set }
    var parentID: String  { get set }
    var name: String? { get set }
    var rectProperties: RectProperties { get set }
    var attributes: [String: Any] { get set }
    var stabilID: String? { get set }
    var childOrder: Double { get set }
    var componentID: String? { get set }
    var child: CNode? { get set }
    var children: [CNode] { get set }
    var componentChildren: [CNode] { get set }
}

extension CNode {
    func toView(view: any View) -> any View {
        return view
    }
}
