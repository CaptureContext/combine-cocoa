//
//  UIControl+Combine.swift
//  CombineCocoa
//
//  Created by Wes Wickwire on 9/23/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
  import CombineExtensions
  import UIKit

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension UIControl {
    /// A publisher emitting events from this control.
    public func publisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
      return Publishers.ControlEvent(
        control: self,
        events: events
      ).eraseToAnyPublisher()
    }
  }
#elseif canImport(Combine) && canImport(AppKit)
  import Combine
  import AppKit

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension NSControl {
    /// A publisher emitting events from this control.
    public func publisher(for events: NSEvent.EventTypeMask) -> AnyPublisher<Void, Never> {
      return Publishers.ControlEvent(
        control: self,
        events: events
      ).eraseToAnyPublisher()
    }
  }
#endif
