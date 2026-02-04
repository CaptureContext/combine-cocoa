//
//  UITableView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 19/01/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit) && canImport(Combine) && !os(watchOS)
import Foundation
import UIKit
import CombineExtensions


extension PublishersProxy where Base: UITableView {
	/// Combine wrapper for `tableView(_:willDisplay:forRowAt:)`
	@MainActor
	public var willDisplayCell: some Publisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:)),
			signature: base.delegate?.tableView(_:willDisplay:forRowAt:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:willDisplayHeaderView:forSection:)`
	@MainActor
	public var willDisplayHeaderView: some Publisher<(headerView: UIView, section: Int), Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:)),
			signature: base.delegate?.tableView(_:willDisplayHeaderView:forSection:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:willDisplayFooterView:forSection:)`
	@MainActor
	public var willDisplayFooterView: some Publisher<(footerView: UIView, section: Int), Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:)),
				signature: base.delegate?.tableView(_:willDisplayFooterView:forSection:)
			)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:didEndDisplaying:forRowAt:)`
	@MainActor
	public var didEndDisplayingCell: some Publisher<
		(cell: UITableViewCell, indexPath: IndexPath),
		Never
	> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:)),
				signature: base.delegate?.tableView(_:didEndDisplaying:forRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:didEndDisplayingHeaderView:forSection:)`
	@MainActor
	public var didEndDisplayingHeaderView: some Publisher<(headerView: UIView, section: Int), Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UITableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:)),
			signature: base.delegate?.tableView(_:didEndDisplayingHeaderView:forSection:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:didEndDisplayingFooterView:forSection:)`
	@MainActor
	public var didEndDisplayingFooterView: some Publisher<(headerView: UIView, section: Int), Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UITableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:)),
			signature: base.delegate?.tableView(_:didEndDisplayingFooterView:forSection:)
		)
		return delegateProxy.proxy_intercept(selector).map { ($0.args.1, $0.args.2) }
	}

	/// Combine wrapper for `tableView(_:accessoryButtonTappedForRowWith:)`
	@MainActor
	public var itemAccessoryButtonTapped: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:)),
				signature: base.delegate?.tableView(_:accessoryButtonTappedForRowWith:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `tableView(_:didHighlightRowAt:)`
	@MainActor
	public var didHighlightRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didHighlightRowAt:)),
				signature: base.delegate?.tableView(_:didHighlightRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `tableView(_:didUnHighlightRowAt:)`
	@MainActor
	public var didUnhighlightRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didUnhighlightRowAt:)),
				signature: base.delegate?.tableView(_:didUnhighlightRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `tableView(_:didSelectRowAt:)`
	@MainActor
	public var didSelectRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)),
				signature: base.delegate?.tableView(_:didSelectRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `tableView(_:didDeselectRowAt:)`
	@MainActor
	public var didDeselectRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:)),
				signature: base.delegate?.tableView(_:didDeselectRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	#if !os(tvOS)
	/// Combine wrapper for `tableView(_:willBeginEditingRowAt:)`
	@MainActor
	public var willBeginEditingRow: some Publisher<IndexPath, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:)),
				signature: base.delegate?.tableView(_:willBeginEditingRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}

	/// Combine wrapper for `tableView(_:didEndEditingRowAt:)`
	@MainActor
	public var didEndEditingRow: some Publisher<IndexPath?, Never> {
		let selector = _makeMethodSelector(
				selector: #selector(UITableViewDelegate.tableView(_:didEndEditingRowAt:)),
				signature: base.delegate?.tableView(_:didEndEditingRowAt:)
			)
		return delegateProxy.proxy_intercept(selector).map(\.args.1)
	}
	#endif

	@MainActor
	public var delegateProxy: TableViewDelegateProxy {
		.proxy(for: base, \.delegate)
	}
}

open class TableViewDelegateProxy:
	DelegateProxy<UITableViewDelegate>,
	UITableViewDelegate
{}
#endif
