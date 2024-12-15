// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BaseMVVMCKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BaseMVVMCKit",
            targets: ["BaseMVVMCKit"]
        ),
    ],
    targets: [
        .target(
            name: "BaseMVVMCKit",
            dependencies: [],
            path: "Source/BaseKit"
        ),
        .testTarget(
            name: "BaseMVVMCKitTests",
            dependencies: ["BaseMVVMCKit"],
            path: "Tests/BaseMVVMCKitTests"
        ),
    ]
)
