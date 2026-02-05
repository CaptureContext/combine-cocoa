# combine-cocoa

[![CI](https://github.com/capturecontext/combine-cocoa/actions/workflows/ci.yml/badge.svg)](https://github.com/capturecontext/combine-cocoa/actions/workflows/ci.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fcombine-cocoa%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/capturecontext/combine-cocoa) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fcombine-cocoa%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/capturecontext/combine-cocoa)

Cocoa extensions for Apple Combine framework.

> [!NOTE]
>
> _The package is in beta_

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
  .upToNextMinor(from: "0.3.0")
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

> [!NOTE]
>
> _The package is compatible with non-Apple platforms, however this package uses conditional compilation, so APIs are only available on Apple platforms_

## License

This library is released under the MIT license. See [LICENCE](LICENCE) for details.

See [ACKNOWLEDGMENTS][ACKNOWLEDGMENTS] for inspiration references and their licences.
