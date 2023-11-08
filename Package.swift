// swift-tools-version: 5.9

import Foundation
import PackageDescription

let package = Package(
  name: "StringBuilder",
  platforms: [.macOS(.v12), .iOS(.v13)],
  products: [
    .library(
      name: "StringBuilder",
      targets: ["StringBuilder"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    .package(url: "https://github.com/flintbox/ANSIEscapeCode", from: "0.1.1"),
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty", from: "0.4.0"),
    .package(url: "https://github.com/apple/swift-service-context.git", from: "1.0.0"),
    .package(url: "https://github.com/rhysforyou/swift-case-accessors", from: "0.2.0"),
    .package(url: "https://github.com/FullQueueDeveloper/IdentifiedEnumCases", from: "1.0.0"),
    .package(url: "https://github.com/pgssoft/XCTestParametrizedMacro", branch: "main"),
  ],
  targets: [
    .target(
      name: "StringBuilder",
      dependencies: [
        "ANSIEscapeCode",
        "IdentifiedEnumCases",

        .product(name: "NonEmpty", package: "swift-nonempty"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "ServiceContextModule", package: "swift-service-context"),
        .product(name: "CaseAccessors", package: "swift-case-accessors"),
      ]
    ),
    .testTarget(
      name: "StringBuilderTests",
      dependencies: [
        "StringBuilder",
        "XCTestParametrizedMacro",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      exclude: ["__Snapshots__"]
    ),
    .executableTarget(name: "TestRunner", dependencies: ["StringBuilder"]),
  ]
)

let swiftSettings: [SwiftSetting] = [
  .enableUpcomingFeature("ConciseMagicFile"),
  .enableUpcomingFeature("BareSlashRegexLiterals"),
  // .enableUpcomingFeature("ExistentialAny"),
  // .enableUpcomingFeature("DisableOutwardActorInference"),
  // .enableUpcomingFeature("ForwardTrailingClosures"),
//  .enableUpcomingFeature("InternalImportsByDefault"),
//  .enableExperimentalFeature("NestedProtocols"),
//  .enableExperimentalFeature("AccessLevelOnImport"),
]

for target in package.targets {
  if !target.isTest {
    var new = target.swiftSettings ?? []
    new += swiftSettings
    target.swiftSettings = new
  }
}

let isXcode = ProcessInfo.processInfo.environment["__CFBundleIdentifier"] == "com.apple.dt.Xcode"
let isSubDependency: () -> Bool = {
  let context = ProcessInfo.processInfo.arguments.drop {
    $0 != "-context"
  }.dropFirst(1).first
  guard let context else {
    return false
  }
  guard let json = (try? JSONSerialization
    .jsonObject(with: context.data(using: .utf8) ?? Data())) as? [String: Any]
  else {
    return false
  }
  guard let packageDirectory = json["packageDirectory"] as? String else {
    return false
  }
  return packageDirectory.contains(".build") || packageDirectory
    .contains("DerivedData") || packageDirectory == "/"
}

if isXcode, !isSubDependency() {
#if !os(Linux)
  if ProcessInfo.processInfo.environment["SWIFT_LINT_SKIP"] != "true" {
    package.dependencies.append(.package(
      url: "https://github.com/realm/SwiftLint.git",
      from: "0.53.0"
    ))

    for target in package.targets {
      var plugin = target.plugins ?? []
      plugin.append(.plugin(name: "SwiftLintPlugin", package: "SwiftLint"))
      target.plugins = plugin
    }
  }
#endif
}

if isXcode, !isSubDependency() {
  if ProcessInfo.processInfo.environment["SWIFT_FORMAT_SKIP"] != "true" {
    package.dependencies.append(.package(
      url: "https://github.com/nicklockwood/SwiftFormat.git",
      from: "0.52.0"
    ))
  }
}

if !isSubDependency() {
  package.dependencies.append(.package(
    url: "https://github.com/apple/swift-docc-plugin.git",
    from: "1.3.0"
  ))
}

if ProcessInfo.processInfo.environment["SWIFT_BUILD_DEPS"] == "true" {
  let dependencies: [Target.Dependency] = package.targets.flatMap {
      return $0.dependencies
  }
  for dependency in dependencies {
    print("DEPENDENCIES:", dependency)
  }
  package.targets.append(.target(name: "_BuildDependencies", dependencies: dependencies))
}
