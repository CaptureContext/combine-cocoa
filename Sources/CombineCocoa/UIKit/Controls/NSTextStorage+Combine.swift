//
//  NSTextStorage+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
  import UIKit
  import CombineExtensions

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: NSTextStorage {
    /// Combine publisher for `NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)`
    public var didProcessEditingRangeChangeInLength:
      AnyPublisher<
        (
          editedMask: NSTextStorage.EditActions,
          editedRange: NSRange,
          delta: Int
        ),
        Never
      >
    {
      let selector = #selector(
        NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)
      )

      return
        delegateProxy
        .interceptSelectorPublisher(selector)
        .map { args -> (editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int) in
          let editedMask = NSTextStorage.EditActions(rawValue: args[1] as! UInt)
          let editedRange = (args[2] as! NSValue).rangeValue
          let delta = args[3] as! Int
          return (editedMask, editedRange, delta)
        }
        .eraseToAnyPublisher()
    }

    public var delegateProxy: NSTextStorageDelegateProxy {
      .createDelegateProxy(for: base)
    }
  }

  @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  open class NSTextStorageDelegateProxy:
    DelegateProxy,
    NSTextStorageDelegate,
    DelegateProxyType
  {
    public func setDelegate(to object: NSTextStorage) {
      object.delegate = self
    }
  }
#endif
