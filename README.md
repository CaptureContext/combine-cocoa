# combine-cocoa

[![CI](https://github.com/CaptureContext/combine-cocoa/actions/workflows/ci.yml/badge.svg)](https://github.com/CaptureContext/combine-cocoa/actions/workflows/ci.yml) [![SwiftPM 5.9](https://img.shields.io/badge/swiftpm-5.9-ED523F.svg?style=flat)](https://swift.org/download/) ![Platforms](https://img.shields.io/badge/Platforms-iOS_13_|_macOS_10.15_|_tvOS_14_|_watchOS_7-ED523F.svg?style=flat) [![@maximkrouk](https://img.shields.io/badge/contact-@capturecontext-1DA1F2.svg?style=flat&logo=twitter)](https://twitter.com/capture_context) 

Cocoa extensions for Apple Combine framework.

> NOTE: The package is in beta

## Installation

### Basic

You can add CombineCocoa to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/combine-cocoa.git"`](https://github.com/capturecontext/combine-cocoa.git) into the package repository URL text field
3. Choose products you need to link them to your project.

### Recommended

If you use SwiftPM for your project, you can add CombineCocoa to your package file.

```swift
.package(
  url: "https://github.com/capturecontext/combine-cocoa.git",
  .upToNextMinor(from: "0.2.0")
)
```

Do not forget about target dependencies:

```swift
.product(
  name: "CombineCocoa", 
  package: "combine-cocoa"
)
```

```swift
.product(
  name: "CombineCocoaMacros", 
  package: "combine-cocoa"
)
```



## License

This library is released under the MIT license. See [LICENCE](LICENCE) for details.

See [ACKNOWLEDGMENTS][ACKNOWLEDGMENTS] for inspiration references and their licences.
