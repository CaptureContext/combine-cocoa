//
//  UICollectionView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 05/04/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit) && canImport(Combine) && !os(watchOS)
  import Foundation
  import UIKit
  import CombineExtensions

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UICollectionView {
    /// Combine wrapper for `collectionView(_:didSelectItemAt:)`
    public var didSelectItem: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didDeselectItemAt:)`
    public var didDeselectItem: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UICollectionViewDelegate.collectionView(_:didDeselectItemAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didHighlightItemAt:)`
    public var didHighlightItem: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UICollectionViewDelegate.collectionView(_:didHighlightItemAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didUnhighlightItemAt:)`
    public var didUnhighlightRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UICollectionViewDelegate.collectionView(_:didUnhighlightItemAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplay:forItemAt:)`
    public var willDisplayCell:
      AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never>
    {
      let selector = #selector(UICollectionViewDelegate.collectionView(_:willDisplay:forItemAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplaySupplementaryView:forElementKind:at:)`
    public var willDisplaySupplementaryView:
      AnyPublisher<
        (
          supplementaryView: UICollectionReusableView,
          elementKind: String,
          indexPath: IndexPath
        ),
        Never
      >
    {
      let selector = #selector(
        UICollectionViewDelegate.collectionView(_:willDisplaySupplementaryView:forElementKind:at:)
      )
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplaying:forItemAt:)`
    public var didEndDisplayingCell:
      AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never>
    {
      let selector = #selector(
        UICollectionViewDelegate.collectionView(_:didEndDisplaying:forItemAt:)
      )
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplayingSupplementaryView:forElementKind:at:)`
    public var didEndDisplaySupplementaryView:
      AnyPublisher<
        (
          supplementaryView: UICollectionReusableView,
          elementKind: String,
          indexPath: IndexPath
        ),
        Never
      >
    {
      let selector = #selector(
        UICollectionViewDelegate.collectionView(
          _:
          didEndDisplayingSupplementaryView:
          forElementOfKind:
          at:
        )
      )
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
        .eraseToAnyPublisher()
    }
    
    public func didEndDeceleratingAtCell(
      _ strategy: UICollectionViewActiveCellDetectionStrategy = .largestVisible
    ) -> AnyPublisher<UICollectionViewCell?, Never> {
      Publishers.Merge3(
        didEndDecelerating,
        didEndScrollingAnimation,
        didEndDragging.compactMap { willDecelerateLater in
          return willDecelerateLater ? nil : ()
        }.eraseToAnyPublisher()
      ).map { [weak base] in
        return base.flatMap(strategy.detect(in:))
      }.eraseToAnyPublisher()
    }

    public var delegateProxy: CollectionViewDelegateProxy {
      .createDelegateProxy(for: base)
    }
  }

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  open class CollectionViewDelegateProxy:
    ScrollViewDelegateProxy,
    UICollectionViewDelegate
  {
    public func setDelegate(to object: UICollectionView) {
      object.delegate = self
    }
  }

  public struct UICollectionViewActiveCellDetectionStrategy {
    let _detect: (UICollectionView) -> UICollectionViewCell?
    public func detect(in collectionView: UICollectionView) -> UICollectionViewCell? {
      return self._detect(collectionView)
    }
    
    public static func custom(_ strategy: @escaping  (UICollectionView) -> UICollectionViewCell?) -> Self {
      return UICollectionViewActiveCellDetectionStrategy(_detect: strategy)
    }
    
    public static var largestVisible: Self {
      .custom { collectionView in
        return collectionView.visibleCells.sorted { cell1, cell2 in
          func area(for view: UIView, in superview: UIView) -> CGFloat {
            let size = view.frame.intersection(superview.bounds).size
            return size.height * size.width
          }
          return area(for: cell1, in: collectionView) > area(for: cell2, in: collectionView)
        }.first
      }
    }
  }
#endif
