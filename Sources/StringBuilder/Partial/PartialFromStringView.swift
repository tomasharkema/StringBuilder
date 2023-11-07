import Algorithms
import ANSIEscapeCode
import ServiceContextModule

// swiftlint:disable:next type_name
public struct _PartialFromStringView {
  private let element: any StringView

  var modifiers: [Modifier.CaseID: Modifier] = [:]

  init(_ element: any StringView) {
    self.element = element
  }
}

extension _PartialFromStringView: PartialBuilable {
  public func line(context: TreeStateContext) -> [PartialBuildElement] {
    let newContext = context.update(modifiers: modifiers)

    let content = newContext.currentBuilder.buildTree(for: element, in: newContext)
    let joined = content.lines.map {
      $0.map {
        PartialBuildElement(line: $0.value, modifiers: newContext.modifiers)
      }
    }
//    let result = joined.joined(by: .init(line: "\n", modifiers: []))
//    let compact = result.compactMap { $0 }
//    return compact
    return joined.flatMap { $0 }
  }
}
