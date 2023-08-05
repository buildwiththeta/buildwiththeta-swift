//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 03/08/23.
//

import Foundation

class NodeRendering {
    
    func buildTree(_ list: [CNode], parentID: String?) throws -> [CNode] {
        var nodes = list.filter { $0.parentID == parentID }
        
        // Sort nodes based on childOrder
        nodes.sort { $0.childOrder < $1.childOrder }
        
        var children: [CNode] = []
        for node in nodes {
            if node.canHave() == .children {
                let children0 = try buildTree(list, parentID: node.id)
                children.append( node.copyWith(parentID: parentID, children: children0))
            } else if node.canHave() == .child {
                let children0 = try buildTree(list, parentID: node.id)
                children.append( node.copyWithoutChild(
                    parentID: parentID, child: children0.isEmpty ? (list.contains(where: { $0.id == children0.first?.id }) ? children0.first : nil) : nil))
            } else {
                children.append( node.copyWith(parentID: parentID))
            }
        }
        print(children)
        return children
    }

    func renderTree(_ list: [CNode]) throws -> CNode {
        return try buildTree(list, parentID: nil).first!
    }

    func renderComponents(_ list: [CNode], pageID: String) -> [CNode] {
        var nodes = list.filter { $0.pageID == pageID }
        for i in 0..<nodes.count {
            if nodes[i].type == "component" || nodes[i].type == "teamComponent" {
                nodes[i] = nodes[i].addChildrenToComponent(componentID: nodes[i].componentID!, children: list)
            }
        }
        return nodes
    }

    func renderFlatList(_ scaffold: CNode) -> [CNode] {
        var nodes = findAllChildren(scaffold)
        nodes.sort { $0.childOrder < $1.childOrder }
        return nodes
    }

    func findAllChildren(_ node: CNode?) -> [CNode] {
        guard let node = node else { return [] }

        var nodes: [CNode] = [node]

        if let child = node.child {
            nodes += findAllChildren(child)
        }

        for child in node.children {
            nodes += findAllChildren(child)
        }

        return nodes
    }
}
