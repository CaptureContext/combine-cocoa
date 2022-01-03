# combine-cocoa

[![SwiftPM 5.3](https://img.shields.io/badge/swiftpm-5.3-ED523F.svg?style=flat)](https://swift.org/download/) ![Platforms](https://img.shields.io/badge/Platforms-iOS_13_|_macOS_10.15_|_tvOS_14_|_watchOS_7-ED523F.svg?style=flat) [![@maximkrouk](https://img.shields.io/badge/contact-@capturecontext-1DA1F2.svg?style=flat&logo=twitter)](https://twitter.com/capture_context) 

Cocoa extensions for Apple Combine framework.

> NOTE: The package is early beta

### TODO

- [x] CombineControlEvent
- [x] CombineControlTarget
- macOS
  - [x] NSControl.ActionHandler
- iOS
  - [x] UIBarButtonItem
  - [x] UICollectionView
  - [x] UIControl
  - [x] UIGestureRecognizer
  - [x] UIScrollView
  - [x] UISearchBar
  - [x] UITableView
  - [x] UITextView
  - [x] Keyboard
  - [x] AnimatedAssignSubscriber (_might be improved_)



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
  name: "combine-cocoa",
  url: "https://github.com/capturecontext/combine-cocoa.git", 
  .upToNextMinor(from: "0.0.2")
)
```

Do not forget about target dependencies:

```swift
.product(
  name: "CombineCocoa", 
  package: "combine-cocoa"
)
```



## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.

See [CREDITS][CREDITS] for inspiration references and their licences.
