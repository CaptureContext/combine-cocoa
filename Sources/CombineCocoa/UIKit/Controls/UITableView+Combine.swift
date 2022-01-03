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

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UITableView {
    /// Combine wrapper for `tableView(_:willDisplay:forRowAt:)`
    public var willDisplayCell: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayHeaderView:forSection:)`
    public var willDisplayHeaderView: AnyPublisher<(headerView: UIView, section: Int), Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UIView, $0[2] as! Int) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayFooterView:forSection:)`
    public var willDisplayFooterView: AnyPublisher<(footerView: UIView, section: Int), Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UIView, $0[2] as! Int) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplaying:forRowAt:)`
    public var didEndDisplayingCell:
      AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never>
    {
      let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingHeaderView:forSection:)`
    public var didEndDisplayingHeaderView: AnyPublisher<(headerView: UIView, section: Int), Never> {
      let selector = #selector(
        UITableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:)
      )
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UIView, $0[2] as! Int) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingFooterView:forSection:)`
    public var didEndDisplayingFooterView: AnyPublisher<(headerView: UIView, section: Int), Never> {
      let selector = #selector(
        UITableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:)
      )
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { ($0[1] as! UIView, $0[2] as! Int) }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:accessoryButtonTappedForRowWith:)`
    public var itemAccessoryButtonTapped: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didHighlightRowAt:)`
    public var didHighlightRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:didHighlightRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didUnHighlightRowAt:)`
    public var didUnhighlightRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:didUnhighlightRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didSelectRowAt:)`
    public var didSelectRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didDeselectRowAt:)`
    public var didDeselectRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    #if !os(tvOS)
    /// Combine wrapper for `tableView(_:willBeginEditingRowAt:)`
    public var willBeginEditingRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndEditingRowAt:)`
    public var didEndEditingRow: AnyPublisher<IndexPath, Never> {
      let selector = #selector(UITableViewDelegate.tableView(_:didEndEditingRowAt:))
      return delegateProxy.interceptSelectorPublisher(selector)
        .map { $0[1] as! IndexPath }
        .eraseToAnyPublisher()
    }
    #endif

    public var delegateProxy: TableViewDelegateProxy {
      .createDelegateProxy(for: base)
    }
  }

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  open class TableViewDelegateProxy: ScrollViewDelegateProxy, UITableViewDelegate {
    public func setDelegate(to object: UITableView) {
      object.delegate = self
    }
  }
#endif
