// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporTestTools",
    products: [
        .library(name: "VaporTestTools", targets: ["VaporTestTools"]),
        ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-beta.3.1.3"),
        ],
    targets: [
        .target(
            name: "VaporTestTools",
            dependencies: [
                "Vapor"
            ]
        ),
        .target(
            name: "App",
            dependencies: [
                "Vapor"
            ]
        ),
        .target(name: "Run", dependencies: [
            "App"
            ]),
        .testTarget(name: "AppTests", dependencies: ["App", "VaporTestTools"])
    ]
)

