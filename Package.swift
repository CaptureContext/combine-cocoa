// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "combine-cocoa",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "CombineCocoa",
      targets: ["CombineCocoa"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/capturecontext/combine-extensions.git",
      .upToNextMinor(from: "0.0.3")
    )
  ],
  targets: [
    .target(
      name: "CombineCocoa",
      dependencies: [
        .product(
          name: "CombineExtensions",
          package: "combine-extensions"
        )
      ]
    )
  ]
)
