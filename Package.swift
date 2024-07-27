// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JLocation",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "JLocation",
            type: .dynamic,
            targets: ["JLocation"]
        )
    ],
    targets: [
        .target(
            name: "JLocation",
            path: "./Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "JLocationTests",
            dependencies: ["JLocation"],
            path: "./Tests"
        )
    ]
)
