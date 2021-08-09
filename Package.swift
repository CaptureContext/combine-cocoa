// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "combine-cocoa",
  products: [
    .library(
      name: "CombineCocoa",
      targets: ["CombineCocoa"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/makeupstudio/combine-extensions.git",
      .upToNextMinor(from: "0.0.1")
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
