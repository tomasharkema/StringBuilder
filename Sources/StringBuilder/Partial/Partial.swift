import ANSIEscapeCode
import ServiceContextModule

public struct Partial {
  public let part: String

  var modifiers = [Modifier.CaseID: Modifier]()

  public init(_ part: String) {
    self.part = part
  }
}

public struct PartialBuildElement {
  let line: String
  let modifiers: [Modifier.CaseID: Modifier]
}

public protocol PartialBuilable {
  func line(context: TreeStateContext) -> [PartialBuildElement]
}

extension Partial: PartialBuilable {
  public func line(context: TreeStateContext) -> [PartialBuildElement] {
    let newContext = context.update(modifiers: modifiers)

    return [PartialBuildElement(line: part, modifiers: newContext.modifiers)]
  }
}

public extension Partial {
  func textColor(_ color: TextColor?) -> Self {
    var newElement = self
    newElement.modifiers[.textColor] = .textColor(color)
    return newElement
  }

  func bold(_ active: Bool = true) -> Self {
    var newElement = self
    newElement.modifiers[.bold] = .bold(enabled: active)
    return newElement
  }
}
