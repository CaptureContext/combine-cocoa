#if canImport(Combine) && os(macOS)
  import AppKit

  extension NSControl {
    @available(macOS 10.10.3, *)
    internal class ActionHandler: NSObject {
      private var actions: [AnyHashable: () -> Void] = [:]

      func setAction(
        forKey key: AnyHashable,
        events: NSEvent.EventTypeMask,
        value action: (() -> Void)?
      ) {
        actions[key] = action.map { action in
          { if events.intersects(.current) { action() } }
        }
      }

      @objc private func handle() {
        actions.values.forEach { $0() }
      }

      func attach(to control: NSControl) {
        control.target = self
        control.action = #selector(handle)
        control.sendAction(on: .any)
      }
    }
  }

  extension NSEvent {
    internal static var current: NSEvent? {
      NSApplication.shared.currentEvent
    }
  }

  extension NSEvent.EventTypeMask {
    @available(macOS 10.10.3, *)
    internal func intersects(_ event: NSEvent?) -> Bool {
      return event?.associatedEventsMask.intersection(self).isEmpty == false
    }
  }
#endif
