#if canImport(Combine) && os(iOS)
  import CombineExtensions
  import Foundation

  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  extension PublishersProxy where Base: NotificationCenter {
    public func keyboard(_ event: KeyboardEvent) -> AnyPublisher<KeyboardChangeContext, Never> {
      return base.publisher(for: event.notificationName)
        .map { KeyboardChangeContext(userInfo: $0.userInfo!, event: event) }
        .eraseToAnyPublisher()
    }
  }
#endif
