import ANSIEscapeCode
import Foundation
import ServiceContextModule

public struct Line: StringView {
  public typealias Body = Never

  private var value: String

  private var modifiers = [Modifier.CaseID: Modifier]()

  public init(_ value: String) {
    self.value = value
  }

  public init(_ content: some StringProtocol) {
    value = String(content)
  }
}

extension Line: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.value = value
  }
}

extension Line: StringBuildable {
  var lines: [[StringBuildableElement]] {
    [[.init(value: value, modifiers: modifiers)]]
  }
}

extension Line: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    var newElement = self
    for (key, modifier) in context.modifiers {
      newElement.modifiers[key] = modifier
    }

    return newElement
  }
}

// extension Line {
//  func adding(_ modifier: Modifier) -> Self {
//    var newElement = self
//    newElement.modifiers.append(modifier)
//    return newElement
//  }
// }
