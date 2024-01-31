//
//  UISearchBar+Combine.swift
//  CombineCocoa
//
//  Created by Kevin Renskers on 01/10/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
import UIKit
import CombineExtensions


extension PublishersProxy where Base: UISearchBar {
	/// Combine wrapper for `UISearchBarDelegate.searchBar(_:textDidChange:)`
	public var textDidChange: some Publisher<String, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UISearchBarDelegate.searchBar(_:textDidChange:)),
			signature: base.delegate?.searchBar(_:textDidChange:)
		)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `UISearchBarDelegate.searchBarSearchButtonClicked(_:)`
	public var searchButtonClicked: some Publisher<Void, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UISearchBarDelegate.searchBarSearchButtonClicked(_:)),
			signature: base.delegate?.searchBarSearchButtonClicked(_:)
		)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	#if !os(tvOS)
	/// Combine wrapper for `UISearchBarDelegate.searchBarCancelButtonClicked(_:)`
	public var cancelButtonClicked: some Publisher<Void, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UISearchBarDelegate.searchBarCancelButtonClicked(_:)),
			signature: base.delegate?.searchBarCancelButtonClicked(_:)
		)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}
	#endif

	private var delegateProxy: UISearchBarDelegateProxy {
		.proxy(for: base, \.delegate)
	}
}


private class UISearchBarDelegateProxy: DelegateProxy<UISearchBarDelegate>, UISearchBarDelegate {}
#endif
