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


extension PublishersProxy where Base: UICollectionView {
	/// Combine wrapper for `collectionView(_:didSelectItemAt:)`
	public var didSelectItem: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:)),
			signature: base.delegate?.collectionView(_:didSelectItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `collectionView(_:didDeselectItemAt:)`
	public var didDeselectItem: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UICollectionViewDelegate.collectionView(_:didDeselectItemAt:)),
			signature: base.delegate?.collectionView(_:didDeselectItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `collectionView(_:didHighlightItemAt:)`
	public var didHighlightItem: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UICollectionViewDelegate.collectionView(_:didHighlightItemAt:)),
			signature: base.delegate?.collectionView(_:didHighlightItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `collectionView(_:didUnhighlightItemAt:)`
	public var didUnhighlightRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UICollectionViewDelegate.collectionView(_:didUnhighlightItemAt:)),
			signature: base.delegate?.collectionView(_:didUnhighlightItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `collectionView(_:willDisplay:forItemAt:)`
	public var willDisplayCell:
	some Publisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never>
	{
		let selector = _makeMethodSelector(
			selector: #selector(UICollectionViewDelegate.collectionView(_:willDisplay:forItemAt:)),
			signature: base.delegate?.collectionView(_:willDisplay:forItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `collectionView(_:willDisplaySupplementaryView:forElementKind:at:)`
	public var willDisplaySupplementaryView:
	some Publisher<
		(
			supplementaryView: UICollectionReusableView,
			elementKind: String,
			indexPath: IndexPath
		),
		Never
	>
	{
		let selector = _makeMethodSelector(
			selector:  #selector(UICollectionViewDelegate.collectionView(
				_:willDisplaySupplementaryView:forElementKind:at:
			)),
			signature: base.delegate?.collectionView(
				_:willDisplaySupplementaryView:forElementKind:at:
			)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2, $0.args.3) }
	}

	/// Combine wrapper for `collectionView(_:didEndDisplaying:forItemAt:)`
	public var didEndDisplayingCell:
	some Publisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never>
	{
		let selector = _makeMethodSelector(
			selector:  #selector(UICollectionViewDelegate.collectionView(_:didEndDisplaying:forItemAt:)),
			signature: base.delegate?.collectionView(_:didEndDisplaying:forItemAt:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `collectionView(_:didEndDisplayingSupplementaryView:forElementKind:at:)`
	public var didEndDisplaySupplementaryView:
	some Publisher<
		(
			supplementaryView: UICollectionReusableView,
			elementKind: String,
			indexPath: IndexPath
		),
		Never
	>
	{
		let selector = _makeMethodSelector(
			selector: #selector(
				UICollectionViewDelegate.collectionView(
					_:didEndDisplayingSupplementaryView:forElementOfKind:at:
				)
			),
			signature: base.delegate?.collectionView(
				_:didEndDisplayingSupplementaryView:forElementOfKind:at:
			)
		)

		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2, $0.args.3) }
	}

	public func didEndDeceleratingAtCell(
		_ strategy: UICollectionViewActiveCellDetectionStrategy = .largestVisible
	) -> some Publisher<UICollectionViewCell?, Never> {
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

		return .proxy(for: base, \.delegate)
	}
}


open class CollectionViewDelegateProxy:
	DelegateProxy<UICollectionViewDelegate>,
	UICollectionViewDelegate
{}

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
