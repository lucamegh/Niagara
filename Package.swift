// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Niagara",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Niagara",
            targets: ["Niagara"]
        )
    ],
    targets: [
        .target(
            name: "Niagara",
            dependencies: []
        ),
        .testTarget(
            name: "NiagaraTests",
            dependencies: ["Niagara"]
        )
    ]
)
