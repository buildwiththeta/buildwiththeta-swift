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
            targets: ["Theta", "Flutter", "App", "FlutterPluginRegistrant"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Theta",
            dependencies: []
        ),
        .binaryTarget(
            name: "Flutter",
            path: "FlutterOutput/Release/Flutter.xcframework"
        ),
        .binaryTarget(
            name: "App",
            path: "FlutterOutput/Release/App.xcframework"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            path: "FlutterOutput/Release/FlutterPluginRegistrant.xcframework"
        ),
        .testTarget(
            name: "ThetaTests",
            dependencies: ["Theta"],
            sources: [
                "ThetaTests.swift",
            ]
        )
    ]
)
