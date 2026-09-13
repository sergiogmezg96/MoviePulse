// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MPLibrary",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MPLibrary",
            targets: ["MPLibrary"]
        )
    ],
    targets: [
        .target(
            name: "MPLibrary",
            path: "Sources/MPLibrary",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
