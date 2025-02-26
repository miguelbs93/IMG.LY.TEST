// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]
        ),
        .library(
            name: "DTOModels",
            targets: ["DTOModels"]
        ),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
        .library(
            name: "Services",
            targets: ["Services"]
        ),
        .library(
            name: "Helpers",
            targets: ["Helpers"]
        ),
        .library(
            name: "TreeScene",
            targets: ["TreeScene"]
        )
    ],
    targets: [
        .target(
            name: "NetworkManager",
            dependencies: []
        ),
        .target(
            name: "Services",
            dependencies: [
                "DTOModels",
                "NetworkManager"
            ]
        ),
        .target(
            name: "DTOModels",
            dependencies: []
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .target(
            name: "Helpers",
            dependencies: []
        ),
        .target(
            name: "TreeScene",
            dependencies: [
                "DTOModels",
                "Models",
                "Services",
                "Helpers",
                "NetworkManager"
            ]
        ),
        .testTarget(
            name: "TreeSceneTests",
            dependencies: [
                "TreeScene"
            ],
            path: "Tests/TreeSceneTests"
        )
    ],
    swiftLanguageModes: [.v5]
)
