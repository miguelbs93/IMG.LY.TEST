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
        )
    ],
    targets: [
        .target(
            name: "NetworkingManager",
            dependencies: []
            )
    ]
)
