//
//  UITextView+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && os(iOS)
  import UIKit
  import CombineExtensions

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UITextView {
    /// A Combine publisher for the `UITextView's` value.
    ///
    /// - note: This uses the underlying `NSTextStorage` to make sure
    ///         autocorrect changes are reflected as well.
    ///
    /// - seealso: https://git.io/JJM5Q
    public var value: AnyPublisher<String?, Never> {
      Deferred { [weak textView = base] in
        textView?.textStorage
          .publishers.didProcessEditingRangeChangeInLength
          .map { _ in textView?.text }
          .prepend(textView?.text)
          .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
    }
  }
#endif
