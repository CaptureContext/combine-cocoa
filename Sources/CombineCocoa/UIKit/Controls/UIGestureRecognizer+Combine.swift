//
//  UIGestureRecognizer+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
  import CombineExtensions
  import UIKit

  // MARK: - Gesture Publishers
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UITapGestureRecognizer {
    /// A publisher which emits when this Tap Gesture Recognizer is triggered
    public var tapGesture: AnyPublisher<UITapGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }

  #if !os(tvOS)
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIPinchGestureRecognizer {
    /// A publisher which emits when this Pinch Gesture Recognizer is triggered
    public var pinchGesture: AnyPublisher<UIPinchGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIRotationGestureRecognizer {
    /// A publisher which emits when this Rotation Gesture Recognizer is triggered
    public var rotationGesture: AnyPublisher<UIRotationGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }
  #endif

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UISwipeGestureRecognizer {
    /// A publisher which emits when this Swipe Gesture Recognizer is triggered
    public var swipeGesture: AnyPublisher<UISwipeGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIPanGestureRecognizer {
    /// A publisher which emits when this Pan Gesture Recognizer is triggered
    public var panGesture: AnyPublisher<UIPanGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }

  #if !os(tvOS)
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UIScreenEdgePanGestureRecognizer {
    /// A publisher which emits when this Screen Edge Gesture Recognizer is triggered
    public var screenEdgePanGesture: AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }
  #endif

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: UILongPressGestureRecognizer {
    /// A publisher which emits when this Long Press Recognizer is triggered
    public var longPressGesture: AnyPublisher<UILongPressGestureRecognizer, Never> {
      gesturePublisher(for: base)
    }
  }

  // MARK: - Private Helpers

  // A private generic helper function which returns the provided
  // generic publisher whenever its specific event occurs.
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  private func gesturePublisher<Gesture: UIGestureRecognizer>(
    for gesture: Gesture
  ) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(
      control: gesture,
      addTargetAction: { gesture, target, action in
        gesture.addTarget(target, action: action)
      },
      removeTargetAction: { gesture, target, action in
        gesture?.removeTarget(target, action: action)
      }
    )
    .subscribe(on: DispatchQueue.main)
    .map { gesture }
    .eraseToAnyPublisher()
  }
#endif
