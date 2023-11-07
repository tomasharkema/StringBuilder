import Algorithms
import ServiceContextModule

public struct List: StringView, PartialBuilable {
  public typealias Body = Never
  private let separator: String
  private let parts: () -> [any PartialBuilable]

  public init(separator: String, @PartialBuilder _ handler: @escaping () -> [any PartialBuilable]) {
    self.separator = separator
    parts = handler
  }
}

extension List: TreeBuildingView {
  public func line(context: TreeStateContext) -> [PartialBuildElement] {
    let elements = parts()
    let mapped = elements.map {
      $0.line(context: context)
    }

    if !separator.isEmpty {
      let join = mapped.joined(by: PartialBuildElement(line: separator, modifiers: [:]))
      let flat = join.compactMap { $0 }
      return flat
    } else {
      let flat = mapped.flatMap { $0 }
      return flat
    }
  }

  func buildTree(in context: TreeStateContext) -> any StringBuildable {
//    let ansiEnabled = context.isAnsiEnabled
    let items = line(context: context)

    let mapped = items.map { part in
      StringBuildableElement(value: part.line, modifiers: part.modifiers)
    }
    return _ConcatLines(lines: [mapped])
  }
}
