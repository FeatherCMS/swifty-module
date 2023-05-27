// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swifty-module",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(name: "SwiftyModule", targets: ["SwiftyModule"]),
    ],
    dependencies: [
//		.package(path: "../feather-core"),
        .package(url: "https://github.com/rando-Coderissian/feather-core", .branch("test-refactored-modules")),
		
//        .package(url: "https://github.com/feathercms/feather-core", .branch("dev")),
        .package(url: "https://github.com/JohnSundell/Splash", from: "0.16.0"),
    ],
    targets: [
        .target(name: "SwiftyModule", dependencies: [
            .product(name: "FeatherCore", package: "feather-core"),
            .product(name: "Splash", package: "Splash"),
        ],
        resources: [
            .copy("Bundle"),
        ]),
    ]
)
