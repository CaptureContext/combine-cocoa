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


extension PublishersProxy where Base: UIScrollView {

	/// A publisher emitting if the bottom of the UIScrollView is reached.
	///
	/// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
	///                     Defaults to 0
	/// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
	public func reachedBottom(offset: CGFloat = 0) -> some Publisher<Void, Never> {
		base.publisher(for: \.contentOffset)
			.map { [weak base] contentOffset -> Bool in
				guard let base = base else { return false }
				let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
				let yDelta = contentOffset.y + base.contentInset.top
				let threshold = max(offset, base.contentSize.height - visibleHeight)
				return yDelta > threshold
			}
			.removeDuplicates()
			.compactMap { $0 ? () : nil }
	}

	public var didEndDecelerating: some Publisher<Void, Never> {
		let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	public var didEndDragging: some Publisher<Bool, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UIScrollViewDelegate.scrollViewDidEndDragging),
			signature: base.delegate?.scrollViewDidEndDragging
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	public var didEndScrollingAnimation: some Publisher<Void, Never> {
		let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	public var delegateProxy: AnyDelegateProxy {
		if let base = base as? UITableView {
			return TableViewDelegateProxy.proxy(for: base, \.delegate)
		} else if let base = base as? UICollectionView {
			return CollectionViewDelegateProxy.proxy(for: base, \.delegate)
		} else {
			return ScrollViewDelegateProxy.proxy(for: base, \.delegate)
		}
	}
}

open class ScrollViewDelegateProxy:
	DelegateProxy<UIScrollViewDelegate>,
	UIScrollViewDelegate
{}
#endif
