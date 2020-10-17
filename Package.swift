// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIPDF",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "SwiftUIPDF",
            targets: ["SwiftUIPDF"]),
    ],
    targets: [
        .target(
            name: "SwiftUIPDF",
            dependencies: []),
        .testTarget(
            name: "SwiftUIPDFTests",
            dependencies: ["SwiftUIPDF"],
            resources: [.copy("Resources/sample.pdf")]),
    ]
)
