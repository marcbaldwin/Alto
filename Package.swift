// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Alto",
  platforms: [.iOS(.v12)],
  products: [
      .library(name: "Alto", targets: ["Alto"])
  ],
  targets: [
    .target(
      name: "Alto",
      exclude: ["Info.plist"]
    ),
    .testTarget(
      name: "AltoTests",
      dependencies: ["Alto"],
      exclude: ["Info.plist"]
    )
  ],
  swiftLanguageModes: [.v5]
)
