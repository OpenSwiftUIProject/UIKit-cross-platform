// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "UIKit",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "UIKit", targets: ["UIKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftAndroid/swift-jni", from: "3.0.0"),
        .package(
            url: "https://github.com/flowkey/SDL2-SwiftPackageManager",
            revision: "4c417816a3b1a8551148f101f580dd0de0aab7bd"
        ),
    ],
    targets: [
        .target(
            name: "UIKit",
            dependencies: [
                .product(name: "SDL", package: "SDL2-SwiftPackageManager"),
                .product(name: "JNI", package: "swift-jni", condition: .when(platforms: [.android])),
                .target(name: "UIKit_C_API", condition: .when(platforms: [.android])),
            ],
            path: "Sources",
            exclude: ["Mac-Info.plist"],
            swiftSettings: [.interoperabilityMode(.Cxx, .when(platforms: [.android]))]
        ),
        .target(name: "UIKit_C_API", path: "UIKit_C_API"),
    ],
    swiftLanguageModes: [.v5]
)
