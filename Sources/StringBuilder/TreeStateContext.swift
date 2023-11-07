import ANSIEscapeCode
import ServiceContextModule

public struct TreeStateContext {
  static let `default` = TreeStateContext()

  private(set) var currentBuilder = StringTreeBuilder.default

  private(set) var modifiers = [Modifier.CaseID: Modifier]()
  private(set) var environment = EnvironmentValues.empty

  var isAnsiEnabled: Bool {
    environment.ansiEnabled
  }

  var isFormattingEnabled: Bool {
    environment.formattingEnabled
  }

  private func withScreenSize(screenSize: ScreenSize?) -> Self {
    if let screenSize {
      var newContext = self
      newContext.environment[keyPath: \.screenSize] = screenSize
      return newContext
    }
    return self
  }

  func withAutomatic() -> Self {
    if let screenSize = readScreenSize() {
      withAnsi(true).withScreenSize(screenSize: screenSize)
    } else {
      self
    }
  }

  func withAnsi(_ enabled: Bool) -> Self {
    var newContext = self
    newContext.environment[keyPath: \.ansiEnabled] = enabled
    return newContext
  }

  func withFormatting(_ enabled: Bool) -> Self {
    var newContext = self
    newContext.environment[keyPath: \.formattingEnabled] = enabled
    return newContext
  }

  func withBold(_ active: Bool) -> Self {
    var newContext = self
    newContext.modifiers[.bold] = .bold(enabled: active)
    return newContext
  }

  func withTextColor(_ color: TextColor) -> Self {
    var newContext = self
    newContext.modifiers[.textColor] = .textColor(color)
    return newContext
  }

  func update(modifiers: [Modifier.CaseID: Modifier]) -> Self {
    var newContext = self
    for (key, modifier) in modifiers {
#if DEBUG
      if newContext.modifiers[key] == modifier {
        assertionFailure("\(key) already set to \(modifier)")
      }
#endif
      newContext.modifiers[key] = modifier
    }
    return newContext
  }

  func update(modifier: EnvironmentKeyWritingModifier<some Any>) -> Self {
    var newContext = self
    newContext.environment[keyPath: modifier.keyPath] = modifier.value
    return newContext
  }
}

enum ContextLocalKey: ServiceContextKey {
  typealias Value = TreeStateContext
  static var nameOverride: String? { "context-key" }
}
