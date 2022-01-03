//
//  UIScrollView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 09/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
  import UIKit
  import CombineExtensions

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIScrollView {

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///
    /// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
    ///                     Defaults to 0
    /// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
    public func reachedBottom(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
      base.publisher(for: \.contentOffset)
        .map { [weak base] contentOffset -> Bool in
          guard let base = base else { return false }
          let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
          let yDelta = contentOffset.y + base.contentInset.top
          let threshold = max(offset, base.contentSize.height - visibleHeight)
          return yDelta > threshold
        }
        .removeDuplicates()
        .filter { $0 }
        .map { _ in () }
        .eraseToAnyPublisher()
    }
    
    public var didEndDecelerating: AnyPublisher<Void, Never> {
      let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating)
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    public var didEndDragging: AnyPublisher<Bool, Never> {
      let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDragging)
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! Bool }
        .eraseToAnyPublisher()
    }
    
    public var didEndScrollingAnimation: AnyPublisher<Void, Never> {
      let selector = #selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation)
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    public var delegateProxy: ScrollViewDelegateProxy {
      if let base = base as? UITableView {
        return TableViewDelegateProxy.createDelegateProxy(for: base)
      } else if let base = base as? UICollectionView {
        return CollectionViewDelegateProxy.createDelegateProxy(for: base)
      } else {
        return ScrollViewDelegateProxy.createDelegateProxy(for: base)
      }
    }
  }

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  open class ScrollViewDelegateProxy:
    DelegateProxy,
    UIScrollViewDelegate,
    DelegateProxyType
  {
    public func setDelegate(to object: UIScrollView) {
      object.delegate = self
    }
  }
#endif
