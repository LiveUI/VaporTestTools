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
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.5.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-alpha.2")
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

