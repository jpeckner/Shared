// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "Shared", targets: ["Shared"]),
        .library(name: "SharedTestComponents", targets: ["SharedTestComponents"]),
    ],
    targets: [
        .target(
            name: "Shared",
            path: "Shared",
            exclude: ["Info.plist", "Shared.h"]
        ),
        .target(
            name: "SharedTestComponents",
            dependencies: ["Shared"],
            path: "SharedTestComponents",
            exclude: [
                "Info.plist",
                "SharedTestComponents.h",
                "Sourcery/Templates",
            ]
        ),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared", "SharedTestComponents"],
            path: "SharedTests",
            exclude: ["Info.plist"]
        ),
    ]
)
