//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import SwiftUI

typealias ErrorView = ((Error) -> AnyView)?

struct UIBox: View {
    let name: String
    let branch: String?
    let controller: UIBoxController?
    let placeholder: AnyView?
    let errorView: ErrorView
    let workflows: [Workflow]?
    let overrides: [Override]?
    
    init(name: String, branch: String? = nil, controller: UIBoxController? = nil, placeholder: AnyView? = nil, errorView: ErrorView) {
        self.name = name
        self.branch = branch
        self.controller = controller
        self.placeholder = placeholder
        self.errorView = errorView
    }
    
    var body: some View {
        LocalNotifier<AnyView>(workflows: workflows, overrides: overrides) {
            LogicBox(componentName: name, branch: branch, controller: controller, placeholder: placeholder, errorView: errorView)
        }
    }
}

struct LogicBox: View {
    let name: String
    let branch: String?
    let controller: UIBoxController?
    let placeholder: AnyView?
    let errorView: ErrorView

    @State private var widget: CNode?
    @State private var error: Error?
    @State private var isLoaded = false
    
    init(componentName: String, branch: String?, controller: UIBoxController?, placeholder: AnyView?, errorView: ErrorView = nil) {
        self.name = componentName
        self.branch = branch
        self.controller = controller
        self.placeholder = placeholder
        self.errorView = errorView
        controller?.setLoadCallback(callback: load)
    }
    
    func load() -> Void {
        
    }
    
    func onLoaded() -> Void {
        isLoaded = true
    }
    
    func onError() -> Void {
        isLoaded = true
        error = RuntimeError("Qualcosa")
    }
    
    var body: some View {
        Group {
            if let err = error {
                if let errorV = errorView {
                    errorV(err)
                } else {
                    AnyView(Text("An error occurred: \(err.localizedDescription)"))
                }
            } else if !isLoaded {
                placeholder ?? AnyView(Text("loading"))
            } else {
                NodeView(node: widget!)
            }
        }
    }
}

struct UIBoxPreview: PreviewProvider {
    static var previews: some View {
        UIBox(name: "Counter View", branch: "Version 2.0", errorView: { error in
            AnyView(Text("\(error.localizedDescription)"))
        })
    }
}
