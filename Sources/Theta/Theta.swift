class Theta {
    // A private initializer to prevent direct instantiation
    private init() {}

    // Shared instance
    static let shared = Theta()

    var isInitialized: Bool = false

    // Replace with your actual client or service type
    var client: Any?

    // Initialize function, similar to the Dart one
    class func initialize(
        anonKey: String,
        connectionMode: ConnectionMode = .continuous,
        customPreloadedJson: [String: Any]? = nil,
        cacheExtension: Int = 43200
    ) await -> Theta {
        // Call the private initializer
        shared._init(anonKey: anonKey, cacheExtension: cacheExtension, connectionMode: connectionMode, customPreloadedJson: customPreloadedJson)

        print("Theta init completed \(shared)")
        return Future.value(shared) // Just a placeholder; you might want to replace this with your async operation.
    }

    private func _init(
        anonKey: String,
        cacheExtension: Int,
        connectionMode: ConnectionMode,
        customPreloadedJson: [String: Any]?
    ) {
        isInitialized = true
    }
    
    func initializeCore() async {
        client = ThetaClient
    }

    // Another placeholder function, assuming `Either` is some kind of Result type you're using
    func build(_ componentName: String) -> Either<Error, Any> {
        // Call your client's build function or equivalent
        return Either.right(Any()) // Placeholder
    }

    func dispose() {
        // Cleanup or dispose resources
        isInitialized = false
    }
}
