// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LogTools",
    platforms: [.macOS(.v11), .iOS(.v14), .watchOS(.v7), .tvOS(.v14)],
    products: [
        .library(name: "LogTools", targets: ["LogTools"]),
    ],
    targets: [
        .target(name: "LogTools")
    ]
)
