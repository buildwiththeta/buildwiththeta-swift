// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let package = Package(
    name: "Theta",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v13),
        .macOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Theta",
            targets: ["Theta"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4")),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Theta",
            dependencies: ["SwiftyJSON", "Alamofire", "Swinject"]),
        .testTarget(
            name: "ThetaTests",
            dependencies: ["Theta", "SwiftyJSON", "Alamofire"],
            sources: [
                "ThetaTests.swift",
                "FMarginsTests.swift",
                "FSizeTests.swift",
                "GetComponentRequest.swift"
            ]
        )
    ]
)
