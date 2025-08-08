// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LifeMapCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "LifeMapCore",
            targets: ["LifeMapCore"]),
    ],
    targets: [
        .target(
            name: "LifeMapCore"),

    ]
)
