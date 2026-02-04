//
//  AnimatedAssignSubscriber.swift
//  CombineCocoa
//
//  Created by Marin Todorov on 05/03/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation

#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
import Combine
import UIKit

/// A list of animations that can be used with `Publisher.assign(to:on:animation:)`

public enum AssignTransition {
	public enum Direction {
		case top, bottom, left, right

		var uiViewFlipAnimationOption: UIView.AnimationOptions {
			switch self {
			case .bottom: .transitionFlipFromBottom
			case .top: .transitionFlipFromTop
			case .left: .transitionFlipFromLeft
			case .right: .transitionFlipFromRight
			}
		}
	}
	
	/// Default flip from either bottom, top, left, or right.
	public static func flip(direction: Direction, duration: TimeInterval) -> AssignTransition {
		.transition(
			duration: duration,
			options: direction.uiViewFlipAnimationOption,
		)
	}

	/// Default cross fade with previous value.
	public static func fade(duration: TimeInterval) -> AssignTransition {
		.transition(
			duration: duration,
			options: .transitionCrossDissolve,
		)
	}

	/// A custom animation. Do not include your own code to update the target of the assign subscriber.
	case animation(
		delay: TimeInterval = 0,
		duration: TimeInterval,
		options: UIView.AnimationOptions = [],
		animations: () -> Void = {},
		completion: ((Bool) -> Void)? = nil
	)

	/// A custom transition. Do not include your own code to update the target of the assign subscriber.
	case transition(
		duration: TimeInterval,
		options: UIView.AnimationOptions,
		animations: () -> Void = {},
		completion: ((Bool) -> Void)? = nil
	)
}

extension Publisher where Self.Failure == Never, Output: Sendable {
	/// Behaves identically to `Publisher.assign(to:on:)` except that it allows the user to
	/// "wrap" emitting output in an animation transition.
	///
	/// For example if you assign values to a `UILabel` on screen you
	/// can make it flip over when each new value is set:
	///
	/// ```
	/// myPublisher
	///   .assign(to: \.text,
	///             on: myLabel,
	///             animation: .flip(direction: .bottom, duration: 0.33))
	/// ```
	///
	/// You may also provide a custom animation block, as follows:
	///
	/// ```
	/// myPublisher
	///   .assign(to: \.text, on: myLabel, animation: .animation(duration: 0.33, options: .curveEaseIn, animations: { _ in
	///     myLabel.center.x += 10.0
	///   }, completion: nil))
	/// ```
	@MainActor
	public func assign<Root: UIView>(
		to keyPath: ReferenceWritableKeyPath<Root, Self.Output> & Sendable,
		on object: Root,
		animation: AssignTransition
	) -> AnyCancellable {
		switch animation {
		case let .transition(duration, options, animations, completion):
			return handleEvents(receiveOutput: { value in
				UIView.transition(
					 with: object,
					 duration: duration,
					 options: options,
					 animations: {
						 object[keyPath: keyPath] = value
						 animations()
					 },
					 completion: completion
				 )
			 })
			 .sink { _ in }
		case let .animation(delay, interval, options, animations, completion):
			return handleEvents(
				receiveOutput: { value in
					UIView.animate(
						withDuration: interval,
						delay: delay,
						options: options,
						animations: {
							object[keyPath: keyPath] = value
							animations()
						},
						completion: completion
					)
				}
			)
			.sink { _ in }
		}

	}
}
#endif
