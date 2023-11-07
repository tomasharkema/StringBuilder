import ANSIEscapeCode

public struct BoldLine: StringModifier {
  let active: Bool

  public init(_ active: Bool = true) {
    self.active = active
  }
}

public extension StringView {
  @inlinable
  func bold(_ active: Bool = true) -> ModifiedContent<Self, BoldLine> {
    modifier(BoldLine(active))
  }
}
