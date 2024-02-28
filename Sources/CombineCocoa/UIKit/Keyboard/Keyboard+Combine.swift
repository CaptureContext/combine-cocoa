#if canImport(Combine) && os(iOS)
import CombineExtensions
import Foundation


extension PublishersProxy where Base: NotificationCenter {
	public func keyboard(_ event: KeyboardEvent) -> AnyPublisher<KeyboardChangeContext, Never> {
		return base.publisher(for: event.notificationName)
			.map { KeyboardChangeContext(userInfo: $0.userInfo!, event: event) }
			.eraseToAnyPublisher()
	}
}
#endif
