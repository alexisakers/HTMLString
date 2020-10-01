// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HTMLString",
    products: [
        .library(name: "HTMLString", targets: ["HTMLString"])
    ],
    targets: [
        .target(name: "HTMLString"),
        .testTarget(
            name: "HTMLStringTests",
            dependencies: ["HTMLString"],
            exclude: ["HTMLStringObjcTests.m"],
            resources: [
                .process("Fixtures")
            ]
        )
    ]
)
