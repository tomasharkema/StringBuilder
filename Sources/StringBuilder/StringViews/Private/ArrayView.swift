
// swiftlint:disable:next type_name
public struct _ArrayView: StringView {
  public typealias Body = Never

  let elements: [any StringView]

  init(_ elements: [any StringView]) {
    self.elements = elements
  }

  init(_ elements: any StringView...) {
    self.elements = elements
  }
}

extension _ArrayView: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    let strings = elements.compactMap {
      context.currentBuilder.buildTree(for: $0, in: context)
    }
    return _MultipleLines(other: strings)
  }
}
