#if canImport(Combine) && canImport(UIKit) && !os(watchOS)
import UIKit
import CombineExtensions

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

	public var willDismiss: some Publisher<Void, Never> {
		let selector = #selector(UIAdaptivePresentationControllerDelegate.presentationControllerWillDismiss)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	public var didDismiss: some Publisher<Void, Never> {
		let selector = #selector(UIAdaptivePresentationControllerDelegate.presentationControllerDidDismiss)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}

	public var didAttemptToDismiss: some Publisher<Void, Never> {
		let selector = #selector(UIAdaptivePresentationControllerDelegate.presentationControllerDidAttemptToDismiss)
		return delegateProxy.proxy_intercept(selector).replaceOutput(with: ())
	}
}

extension PublishersProxy where Base: UIPresentationController {
	public var delegateProxy: UIAdaptivePresentationControllerDelegateProxy {
		return .proxy(for: base, \.delegate)
	}
}

open class UIAdaptivePresentationControllerDelegateProxy:
	DelegateProxy<UIAdaptivePresentationControllerDelegate>,
	UIAdaptivePresentationControllerDelegate
{}
#endif
