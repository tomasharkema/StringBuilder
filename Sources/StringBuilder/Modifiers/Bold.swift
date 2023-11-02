import ANSIEscapeCode

public struct BoldLine: StringModifier {
  private let active: Bool

  public init(_ active: Bool = true) {
    self.active = active
  }

  public func body(content: any StringBuildable) -> any StringBuildable {
    Map(content) {
      if active {
        $0.boldOutput
      } else {
        $0
      }
    }
  }
}

public extension StringBuildable {
  func bold(_ active: Bool = true) -> any StringBuildable {
    modifier(BoldLine(active))
  }
}
