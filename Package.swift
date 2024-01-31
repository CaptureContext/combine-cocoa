// swift-tools-version:5.9

import PackageDescription

let package = Package(
	name: "combine-cocoa",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.macCatalyst(.v13),
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
			branch: "0.2.0-alpha"
		),
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
