// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jLocation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "jLocation",
            type: .dynamic,
            targets: ["jLocation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JordanHaer/jNetworking", branch: "nobeaver")
    ],
    targets: [
        .target(
            name: "jLocation",
            dependencies: [
                .product(name: "jNetworking", package: "jNetworking"),
            ],
            path: "./Sources"
        ),
        .testTarget(
            name: "jLocationTests",
            dependencies: ["jLocation"],
            path: "./Tests"
        ),
    ]
)
