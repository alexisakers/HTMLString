// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "HTMLString",
    products: [
        .library(name: "HTMLString", targets: ["HTMLString"])
    ],
    targets: [
        .target(name: "HTMLString"),
        .testTarget(name: "HTMLStringTests", dependencies: ["HTMLString"])
    ]
)
