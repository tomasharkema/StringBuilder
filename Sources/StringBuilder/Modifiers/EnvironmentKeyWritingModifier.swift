
public struct EnvironmentKeyWritingModifier<Value>: StringModifier {
  typealias EnvironmentKeyPath = WritableKeyPath<EnvironmentValues, Value>

  let keyPath: EnvironmentKeyPath
  let value: Value

  init(_ keyPath: EnvironmentKeyPath, _ value: Value) {
    self.keyPath = keyPath
    self.value = value
  }
}

public extension StringView {
  func environment<Value>(
    _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
    _ value: Value
  ) -> ModifiedContent<Self, EnvironmentKeyWritingModifier<Value>> {
    modifier(EnvironmentKeyWritingModifier(keyPath, value))
  }
}
