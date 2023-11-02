// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "StringBuilder",
    products: [
        .library(
            name: "StringBuilder",
            targets: ["StringBuilder"]),
    ],
    dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    .package(url: "https://github.com/flintbox/ANSIEscapeCode", from: "0.1.1"),
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty", from: "0.4.0"),
    ],
    targets: [
        .target(
            name: "StringBuilder",
dependencies: [
    "ANSIEscapeCode",

        .product(name: "Algorithms", package: "swift-algorithms"),        .product(name: "NonEmpty", package: "swift-nonempty"),

]
            ),
        .testTarget(
            name: "StringBuilderTests",
            dependencies: [
                "StringBuilder",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
                ]),
    ]
)

let swiftSettings: [SwiftSetting] = [
  .enableUpcomingFeature("ConciseMagicFile"),
  .enableUpcomingFeature("BareSlashRegexLiterals"),
  .enableUpcomingFeature("ExistentialAny"),
  .enableUpcomingFeature("DisableOutwardActorInference"),
  .enableUpcomingFeature("ForwardTrailingClosures"),
  .enableUpcomingFeature("InternalImportsByDefault"),
  .enableExperimentalFeature("NestedProtocols"),
  .enableExperimentalFeature("AccessLevelOnImport"),
]

for target in package.targets {
    var new = target.swiftSettings ?? []
    new += swiftSettings
    target.swiftSettings = new
}