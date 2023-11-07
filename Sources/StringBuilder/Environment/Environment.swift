import ServiceContextModule

@propertyWrapper
public struct Environment<Value> /*: DynamicViewProperty */ {
  let keyPath: KeyPath<EnvironmentValues, Value>

  public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
    self.keyPath = keyPath
  }

  public var wrappedValue: Value {
    guard let context = ServiceContext.current?[ContextLocalKey.self] else {
      fatalError("you cannot access @Environment outside of `body`")
    }
    return context.environment[keyPath: keyPath]
  }
}
