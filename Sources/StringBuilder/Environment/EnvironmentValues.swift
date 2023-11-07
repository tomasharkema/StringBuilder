import Foundation

public struct EnvironmentValues: Sendable {
  static let empty = EnvironmentValues()

  private var values = [ObjectIdentifier: AnySendable]()

  public subscript<K: EnvironmentKey>(key: K.Type) -> K.Value {
    get {
      let id = ObjectIdentifier(key.self)
      guard let sendable = values[id] else {
        return K.defaultValue
      }
      let value = sendable.base
      guard let typedValue = value as? K.Value else {
        assertionFailure("unexpected typed value: \(value)")
        return K.defaultValue
      }
      return typedValue
    }
    set {
      let id = ObjectIdentifier(key.self)
      values[id] = AnySendable(newValue)
    }
  }
}

struct AnySendable: @unchecked Sendable {
  let base: Any
  @inlinable
  init(_ base: some Sendable) {
    self.base = base
  }
}
