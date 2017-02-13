import PackageDescription

let targets = [
    Target(name: "HTMLString"),
    // Target(name: "Performance", dependencies: [.Target(name: "HTMLString")])
]

let excludes: [String] = [
    "Sources/Performance",
    "HTMLStringObjC"
]

let package = Package(
    name: "HTMLString",
    targets: targets,
    exclude: excludes
)
