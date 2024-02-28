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

extension PublishersProxy where Base: NSTextStorage {
	/// Combine publisher for `NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)`
	public var didProcessEditingRangeChangeInLength:
	some Publisher<
		(
			editedMask: NSTextStorage.EditActions,
			editedRange: NSRange,
			delta: Int
		),
		Never
	> {
		let selector = _makeMethodSelector(
			selector: #selector(NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)),
			signature: base.delegate?.textStorage(_:didProcessEditing:range:changeInLength:)
		)

		return delegateProxy
			.proxy_intercept(selector)
			.map { result in
				(
					result.args.1,
					result.args.2,
					result.args.3
				)
			}
	}

	public var delegateProxy: NSTextStorageDelegateProxy {
		return .proxy(for: base, \.delegate)
	}
}

open class NSTextStorageDelegateProxy:
	DelegateProxy<NSTextStorageDelegate>,
	NSTextStorageDelegate
{}
#endif
