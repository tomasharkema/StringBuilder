import ANSIEscapeCode

public struct LineColor: StringModifier {
  let color: TextColor

  public init(_ color: TextColor) {
    self.color = color
  }
}

public extension StringView {
  func textColor(_ color: TextColor) -> some StringView {
    modifier(LineColor(color))
  }
}
