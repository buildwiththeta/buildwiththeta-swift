//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

class CNode {
    var id: String
    var type: String
    var parentID: String
    var pageID: String
    var componentID: String?
    var name: String?
    var rectProperties: RectProperties
    var attributes: [String: Decodable]
    var stabilID: String?
    var childOrder: Double
    var child: CNode?
    var children: [CNode]
    var componentChildren: [CNode]
    
    init(json: JSON) throws {
        let decoder = JSONDecoder()
        
        self.id = json["id"].string!
        self.type = json["type"].string!
        self.parentID = json["parent_id"].string!
        self.pageID = json["page_id"].string!
        self.componentID = json["component_id"].string
        self.name = json["name"].string
        let rectPropertiesData = try json["rect_properties"].rawData()
        self.rectProperties = try decoder.decode(RectProperties.self, from: rectPropertiesData)
        self.attributes = json["properties"].dictionaryValue
    }
    
    init(id: String, type: String, parentID: String, pageID: String, componentID: String?, name: String? = nil, rectProperties: RectProperties, attributes: [String : Decodable], stabilID: String? = nil, childOrder: Double, child: CNode? = nil, children: [CNode], componentChildren: [CNode]) {
        self.id = id
        self.type = type
        self.parentID = parentID
        self.pageID = pageID
        self.componentID = componentID
        self.name = name
        self.rectProperties = rectProperties
        self.attributes = attributes
        self.stabilID = stabilID
        self.childOrder = childOrder
        self.child = child
        self.children = children
        self.componentChildren = componentChildren
    }
    
    func canHave() -> ChildrenCapability {
        switch (self.type) {
            case "text": return .none
            case "image": return .none
            case "icon": return .none
            case "container": return .child
            case "align": return .child
            case "column": return .children
            case "row": return .children
            case "listView": return .children
            default:
                return .none
        }
    }
    
    func toView(view: any View) -> any View {
        return view
    }
    
    func copyWith(
        id: String? = nil,
        type: String? = nil,
        parentID: String? = nil,
        pageID: String? = nil,
        name: String? = nil,
        rectProperties: RectProperties? = nil,
        attributes: [String: Decodable]? = nil,
        stabilID: String? = nil,
        childOrder: Double? = nil,
        componentID: String? = nil,
        child: CNode? = nil,
        children: [CNode]? = nil,
        componentChildren: [CNode]? = nil
    ) -> CNode {
        return CNode(
            id: id ?? self.id,
            type: type ?? self.type,
            parentID: parentID ?? self.parentID,
            pageID: pageID ?? self.pageID,
            componentID: componentID ?? self.componentID,
            rectProperties: rectProperties ?? self.rectProperties,
            attributes: attributes ?? self.attributes,
            childOrder: childOrder ?? self.childOrder,
            child: child ?? self.child,
            children: children ?? self.children,
            componentChildren: componentChildren ?? self.componentChildren
        )
    }
    
    func copyWithoutChild(
        id: String? = nil,
        type: String? = nil,
        parentID: String? = nil,
        pageID: String? = nil,
        name: String? = nil,
        rectProperties: RectProperties? = nil,
        attributes: [String: Decodable]? = nil,
        stabilID: String? = nil,
        childOrder: Double? = nil,
        componentID: String? = nil,
        child: CNode? = nil,
        children: [CNode]? = nil,
        componentChildren: [CNode]? = nil
    ) -> CNode {
        return CNode(
            id: id ?? self.id,
            type: type ?? self.type,
            parentID: parentID ?? self.parentID,
            pageID: pageID ?? self.pageID,
            componentID: componentID ?? self.componentID,
            rectProperties: rectProperties ?? self.rectProperties,
            attributes: attributes ?? self.attributes,
            childOrder: childOrder ?? self.childOrder,
            child: child,
            children: children ?? self.children,
            componentChildren: componentChildren ?? self.componentChildren
        )
    }

    func addChildrenToComponent(componentID: String, children: [CNode]) -> CNode {
        return _addChildrenToComponent(currentNode: self, componentID: componentID, children: children)
    }

    private func _addChildrenToComponent(
        currentNode: CNode, componentID: String, children: [CNode],
        topComponentsIds: Set<String>? = nil) -> CNode {

        var topComponentsIds = topComponentsIds ?? []

        if topComponentsIds.isEmpty {
            topComponentsIds.insert(currentNode.pageID)
        }
        if currentNode.pageID == componentID || topComponentsIds.contains(currentNode.componentID) {
            return currentNode
        }

        topComponentsIds.insert(currentNode.componentID)

        var newComponentChildren = currentNode.componentChildren

        for child in children {
            var _child = child
            if componentID == child.pageID && componentID == currentNode.componentID {
                if (child.type == "component" || child.type == "teamComponent") && !topComponentsIds.contains(child.componentID) {
                    if !child.componentChildren.contains(where: { $0 === currentNode }) {
                        _child = child._addChildrenToComponent(
                            currentNode: child,
                            componentID: child.componentID,
                            children: children,
                            topComponentsIds: topComponentsIds
                        )
                    }
                }
                newComponentChildren.append(_child)
            }
        }

        topComponentsIds.remove(currentNode.componentID)

        return currentNode.copyWith(componentChildren: newComponentChildren)
    }
}
