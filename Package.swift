// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Retrievers",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Retrievers",
            targets: ["Retrievers"]
        ),
    ],
    targets: [
        .target(
            name: "Retrievers"
        ),
        .testTarget(
            name: "RetrieversTests",
            dependencies: ["Retrievers"]
        ),
    ]
)
