// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "NetworkingManager",
            targets: ["NetworkingManager"]
        ),
        .library(
            name: "DTOModels",
            targets: ["DTOModels"]
        ),
        .library(
            name: "Services",
            targets: ["Services"]
        )
    ],
    targets: [
        .target(
            name: "NetworkingManager",
            dependencies: []
        ),
        .target(
            name: "Services",
            dependencies: [
                "DTOModels",
                "NetworkingManager"
            ]
        ),
        .target(
            name: "DTOModels",
            dependencies: []
        )
    ]
)
