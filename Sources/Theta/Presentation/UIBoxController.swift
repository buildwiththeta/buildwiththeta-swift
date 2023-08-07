//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import SwiftUI
import Combine
import Swinject

typealias ErrorCallback = (Error) -> Void
typealias LoadedCallback = () -> Void

class UIBoxController: ObservableObject {
    var component: ID?
    var componentID: ID?
    var branchName: String?
    var abTestID: ID?
    var onLoadCallback: (() -> Void)?
    var onErrorCallback: ErrorCallback?
    var onLoadedCallback: LoadedCallback?
    var rootNode: CNode?

    // Loads the component.
    func load() {
        onLoadCallback?()
        objectWillChange.send()
    }

    // Returns the list of nodes of the component.
    func nodesToList() -> [CNode] {
        let container = Container()
        let nodeRendering = container.resolve(NodeRendering.self)!
        return nodeRendering.renderFlatList(rootNode!)
    }

    var componentNameValue: String {
        guard let name = component else {
            fatalError("Component name is null. Use after the component is loaded correctly.")
        }
        return name
    }

    var componentIDValue: String {
        guard let id = componentID else {
            fatalError("Component ID is null. Use after the component is loaded correctly.")
        }
        return id
    }

    // Sets the error callback.
    func onError(callback: @escaping ErrorCallback) {
        onErrorCallback = callback
        objectWillChange.send()
    }

    // Sets the loaded callback.
    func onLoaded(callback: @escaping LoadedCallback) {
        onLoadedCallback = callback
        objectWillChange.send()
    }

    // Sets the load callback.
    func setLoadCallback(callback: @escaping () -> Void) {
        onLoadCallback = callback
        objectWillChange.send()
    }

    // Triggers the error callback.
    func triggerError(error: Error) {
        onErrorCallback?(error)
    }

    // Triggers the loaded callback.
    func triggerLoaded(
        node: CNode,
        componentName: String,
        componentID: String,
        branchName: String?,
        abTestID: String?
    ) {
        self.component = componentName
        self.componentID = componentID
        self.abTestID = abTestID
        self.branchName = branchName
        self.rootNode = node
        onLoadedCallback?()
    }
}

// Usage example
struct ContentView: View {
    @ObservedObject var controller = UIBoxController()

    var body: some View {
        // Your SwiftUI content here
        Text(controller.componentNameValue)
    }
}
