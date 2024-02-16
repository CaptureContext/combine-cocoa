#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
import UIKit
import CombineExtensions

extension PublishersProxy where Base: UIViewController {
	public var dismissed: some Publisher<Void, Never> {
		weak var _base = base
		var _presentationStackSnapshot: (root: UIViewController, stack: [UIViewController])?
		return base.publisher(for: \.presentationController)
			.compactMap { $0 }
			.flatMap { presenter in
				Publishers.Merge(
					presenter.publishers.willDismiss.map { presenter in
						guard let _base else { return }
						let root = presenter.presentingViewController
						let stack = root._presentationStack ?? []
						guard stack.contains(_base) else { return }
						_presentationStackSnapshot = (root, stack)
					}.discardOutput(),
					presenter.publishers.didDismiss.compactMap { presenter in
						defer { _presentationStackSnapshot = nil }

						guard let _base else { return nil }
						let newStack = _presentationStackSnapshot?.root._presentationStack ?? []
						return !newStack.contains(_base) ? () : nil
					}
				)
			}
	}

	public var dismiss: some Publisher<[UIViewController], Never> {
		weak var _base = base
		var _presentationStackSnapshot: (root: UIViewController, stack: [UIViewController])?
		return base.publisher(for: \.presentationController)
			.compactMap { $0 }
			.flatMap { presenter in
				Publishers.Merge(
					presenter.publishers.willDismiss.map { presenter in
						guard let _base else { return }
						_presentationStackSnapshot = (_base, _base._presentationStack ?? [])
					}.discardOutput(),
					presenter.publishers.didDismiss.compactMap { presenter in
						defer { _presentationStackSnapshot = nil }

						guard
							let _presentationStackSnapshot,
								!_presentationStackSnapshot.stack.isEmpty
						else { return nil }

						let newStack = _presentationStackSnapshot.root._presentationStack ?? []
						let dismissed = _presentationStackSnapshot.stack.filter { !newStack.contains($0) }
						
						return dismissed ?? [_presentationStackSnapshot.root]
					}
				)
			}
	}
}

extension PublishersProxy where Base: UIPresentationController {
	public var willPresentWithAdaptiveStyle: some Publisher<Void, Never> {
		let selector = #selector(UIAdaptivePresentationControllerDelegate.presentationController(
			_:willPresentWithAdaptiveStyle:transitionCoordinator:
		))
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	public var shouldDismiss: some Publisher<Bool, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UIAdaptivePresentationControllerDelegate.presentationControllerShouldDismiss),
			signature: base.delegate?.presentationControllerShouldDismiss
		)
		return delegateProxy.proxy_intercept(selector).map(\.output)
	}

	public var willDismiss: some Publisher<UIPresentationController, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UIAdaptivePresentationControllerDelegate.presentationControllerWillDismiss),
			signature: base.delegate?.presentationControllerWillDismiss
		)
		return delegateProxy.proxy_intercept(selector).map(\.args)
	}

	public var didDismiss: some Publisher<UIPresentationController, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UIAdaptivePresentationControllerDelegate.presentationControllerDidDismiss),
			signature: base.delegate?.presentationControllerDidDismiss
		)
		return delegateProxy.proxy_intercept(selector).map(\.args)
	}

	public var didAttemptToDismiss: some Publisher<UIPresentationController, Never> {
		let selector = _makeMethodSelector(
			selector: #selector(UIAdaptivePresentationControllerDelegate.presentationControllerDidAttemptToDismiss),
			signature: base.delegate?.presentationControllerDidAttemptToDismiss
		)
		return delegateProxy.proxy_intercept(selector).map(\.args)
	}

	public var delegateProxy: UIAdaptivePresentationControllerDelegateProxy {
		return .proxy(for: base, \.delegate)
	}
}

open class UIAdaptivePresentationControllerDelegateProxy:
	DelegateProxy<UIAdaptivePresentationControllerDelegate>,
	UIAdaptivePresentationControllerDelegate
{
	public func presentationController(
		_ presentationController: UIPresentationController,
		willPresentWithAdaptiveStyle style: UIModalPresentationStyle, 
		transitionCoordinator: UIViewControllerTransitionCoordinator?
	) {
		self.forwardee?.presentationController?(
			presentationController,
			willPresentWithAdaptiveStyle: style,
			transitionCoordinator: transitionCoordinator
		)
	}

	public func presentationControllerShouldDismiss(
		_ presentationController: UIPresentationController
	) -> Bool {
		self.forwardee?.presentationControllerShouldDismiss?(presentationController) ?? true
	}

	@available(iOS 15.0, *)
	public func presentationController(
		_ presentationController: UIPresentationController,
		prepare adaptivePresentationController: UIPresentationController
	) {
		self.forwardee?.presentationController?(
			presentationController,
			prepare: adaptivePresentationController
		)
	}

	public func presentationController(
		_ controller: UIPresentationController,
		viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle
	) -> UIViewController? {
		self.forwardee?.presentationController?(
			controller,
			viewControllerForAdaptivePresentationStyle: style
		)
	}

	public func adaptivePresentationStyle(
		for controller: UIPresentationController,
		traitCollection: UITraitCollection
	) -> UIModalPresentationStyle {
		self.forwardee?.adaptivePresentationStyle?(
			for: controller,
			traitCollection: traitCollection
		) ?? .automatic
	}

	public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		self.forwardee?.adaptivePresentationStyle?(for: controller) ?? .automatic
	}

	public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
		self.forwardee?.presentationControllerWillDismiss?(presentationController)
	}

	public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
		self.forwardee?.presentationControllerDidDismiss?(presentationController)
	}

	public func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
		self.forwardee?.presentationControllerDidAttemptToDismiss?(presentationController)
	}
}

extension UIViewController {
	fileprivate var _presentationStack: [UIViewController]? {
		presentedViewController.map { [$0] + ($0._presentationStack ?? []) }
	}
}
#endif
