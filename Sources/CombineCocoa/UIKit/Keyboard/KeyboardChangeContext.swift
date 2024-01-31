#if canImport(Combine) && os(iOS)
  import Foundation
  import UIKit

  /// The context of an upcoming change in the frame of the system keyboard.
  public struct KeyboardChangeContext {
    private let base: [AnyHashable: Any]

    /// The event type of the system keyboard.
    public let event: KeyboardEvent

    /// The current frame of the system keyboard.
    public var beginFrame: CGRect {
      return base[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
    }

    /// The final frame of the system keyboard.
    public var endFrame: CGRect {
      return base[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    }

    /// The animation curve which the system keyboard will use to animate the
    /// change in its frame.
    public var animationCurve: UIView.AnimationCurve {
      let value = base[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
      return UIView.AnimationCurve(rawValue: value.intValue)!
    }

    /// The duration in which the system keyboard expects to animate the change in
    /// its frame.
    public var animationDuration: Double {
      return base[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    }

    /// Indicates whether the change is triggered locally. Used in iPad
    /// multitasking, where all foreground apps would be notified of any changes
    /// in the system keyboard's frame.
    public var isLocal: Bool {
      return base[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
    }

    internal init(userInfo: [AnyHashable: Any], event: KeyboardEvent) {
      self.base = userInfo
      self.event = event
    }
  }
#endif
