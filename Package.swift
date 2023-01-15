// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "Showcase",
            targets: ["Showcase"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Showcase",
            dependencies: []),
        .testTarget(
            name: "ShowcaseTests",
            dependencies: ["Showcase"]),
    ]
)
