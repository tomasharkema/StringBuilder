
public protocol EnvironmentKey {
  associatedtype Value
  static var defaultValue: Self.Value { get }
}

enum AnsiEnabledKey: EnvironmentKey {
  static var defaultValue: Bool { false }
}

public extension EnvironmentValues {
  var ansiEnabled: Bool {
    set { self[AnsiEnabledKey.self] = newValue }
    get { self[AnsiEnabledKey.self] }
  }
}

enum FormattingEnabledKey: EnvironmentKey {
  static var defaultValue: Bool { true }
}

public extension EnvironmentValues {
  var formattingEnabled: Bool {
    set { self[FormattingEnabledKey.self] = newValue }
    get { self[FormattingEnabledKey.self] }
  }
}

enum ScreenSizeKey: EnvironmentKey {
  static var defaultValue: ScreenSize? { nil }
}

public extension EnvironmentValues {
  var screenSize: ScreenSize? {
    set { self[ScreenSizeKey.self] = newValue }
    get { self[ScreenSizeKey.self] }
  }
}

public extension StringView {
  typealias EnvironmentView<Value: StringModifier> = ModifiedContent<
    Self,
    EnvironmentKeyWritingModifier<Value>
  >
}
