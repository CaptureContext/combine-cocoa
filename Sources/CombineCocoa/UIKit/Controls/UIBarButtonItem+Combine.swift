//
//  UIBarButtonItem+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
  import CombineExtensions
  import UIKit

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIBarButtonItem {
    /// A publisher which emits whenever this UIBarButtonItem is tapped.
    public var tap: AnyPublisher<Void, Never> {
      Publishers.ControlTarget(
        control: base,
        addTargetAction: { control, target, action in
          control.target = target
          control.action = action
        },
        removeTargetAction: { control, _, _ in
          control?.target = nil
          control?.action = nil
        }
      )
      .eraseToAnyPublisher()
    }
  }
#endif
