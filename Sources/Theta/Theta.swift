import Foundation
import Flutter

class Theta {
    let name: String
    let anonKey: String
    let flutterEngine: FlutterEngine = FlutterEngine(name: "io.flutter", project: nil)

    // Initialize function, similar to the Dart one
    init(
        anonKey: String,
        name: String
    ) {
        self.name = name
        self.anonKey = anonKey
        self.flutterEngine.run(withEntrypoint: nil)
    }

    public func createFlutterViewController() -> FlutterViewController {
        return FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    }
}
