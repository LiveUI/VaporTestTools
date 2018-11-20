// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporTestTools",
    products: [
        .library(
            name: "VaporTestTools",
            targets: ["VaporTestTools"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.8.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "VaporTestTools",
            dependencies: [
                "Vapor"
            ]
        ),
        .target(
            name: "AppVaporTestTools",
            dependencies: [
                "Vapor"
            ]
        ),
        .target(
            name: "RunVaporTestTools",
            dependencies: [
                "AppVaporTestTools"
            ]
        ),
        .testTarget(
            name: "VaporTestToolsTests",
            dependencies: [
                "NIO",
                "Vapor",
                "AppVaporTestTools",
                "VaporTestTools"
            ]
        )
    ]
)

