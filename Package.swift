// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Alamofire",
  platforms: [.macOS(.v10_13),
              .iOS(.v12),
              .tvOS(.v12),
              .watchOS(.v4)],
  products: [
      .library(name: "Alto", targets: ["Alto"]),
  ],
  targets: [.target(name: "Alto",
                    path: "Alto",
                    exclude: ["Info.plist"],
                    swiftSettings: [.enableUpcomingFeature("ExistentialAny")]
                    ),
            .testTarget(name: "AltoTests",
                        dependencies: ["Alto"],
                        path: "Tests",
                        exclude: ["Info.plist"],
                        )
  ],
  swiftLanguageModes: [.v5])
