
public protocol StringModifier {
  // associatedtype Body
  typealias Content = any StringBuildable
  typealias Body = any StringBuildable

  func body(content: Self.Content) -> Self.Body
}

public extension StringBuildable {
  func modifier<T>(_ modifier: T) -> ModifiedContent</* any StringBuildable, */ T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}