
import Alamofire

class Theta {
    // A private initializer to prevent direct instantiation
    private init() {}

    // Shared instance
    static let shared = Theta()

    var isInitialized: Bool = false

    // Replace with your actual client or service type
    var client: Client?

    // Initialize function, similar to the Dart one
    class func initialize(
        anonKey: String,
        connectionMode: ConnectionMode = .continuous,
        customPreloadedJson: [String: Any]? = nil,
        cacheExtension: Int = 43200
    ) async -> Void {
        await shared._init(anonKey: anonKey, cacheExtension: cacheExtension, connectionMode: connectionMode, customPreloadedJson: customPreloadedJson)
        print("Theta init completed \(shared)")
    }

    private func _init(
        anonKey: String,
        cacheExtension: Int,
        connectionMode: ConnectionMode,
        customPreloadedJson: [String: Any]?
    ) async -> Void {
        isInitialized = true
        await initializeCore(
            clientToken: ClientToken(token: anonKey),
            preloadFile: PreloadFile(
                enabled: false,
                customJson: nil
            )
        )
    }
    
    func initializeCore(clientToken: ClientToken, preloadFile: PreloadFile) async {
        client = Client(
            getComponentUseCase: GetComponentUseCase(
                componentRepository: ComponentRepositoryImpl(
                    preloadFile: preloadFile,
                    componentService: ComponentService(
                        clientToken: clientToken,
                        httpClient: Session()
                    ),
                    isCacheEnabled: false
                )
            ),
            getStylesUseCase: GetStylesUseCase(
                stylesRepository: StylesRepositoryImpl(
                    stylesService: StylesService(
                        clientToken: clientToken,
                        httpClient: Session()
                    ),
                    preloadFile: preloadFile
                )
            )
        )
    }

    // Another placeholder function, assuming `Either` is some kind of Result type you're using
    func build(_ componentName: String) async throws -> GetComponentResponse {
        return try await client!.build(
            componentName: componentName,
            branchName: nil,
            preloadAllowed: false
        )
    }

    func dispose() {
        // Cleanup or dispose resources
        isInitialized = false
    }
}
