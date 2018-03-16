// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporTestTools",
    products: [
        .library(name: "VaporTestTools", targets: ["VaporTestTools"]),
        ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .branch("nio")),
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
        .target(name: "RunVaporTestTools", dependencies: [
            "AppVaporTestTools"
            ]),
        .testTarget(name: "VaporTestToolsTests", dependencies: ["AppVaporTestTools", "VaporTestTools"])
    ]
)

