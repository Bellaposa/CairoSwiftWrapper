// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CairoExample",
    dependencies: [],
    targets: [
		.systemLibrary(name: "CCairo",
					   pkgConfig: "cairo",
					   providers: [.brew(["cairo"])]),
		.target(
			name: "Cairo",
			dependencies: ["CCairo"]),
        .target(
            name: "CairoExample",
            dependencies: ["Cairo"]),
        .testTarget(
            name: "CairoExampleTests",
            dependencies: ["CairoExample"]),
    ]
)
