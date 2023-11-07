import Foundation

// swiftlint:disable:next type_name
public struct _DoubleView<C0: StringView, C1: StringView>: StringView {
  let content: (C0, C1)

  init(_ content: (C0, C1)) {
    self.content = content
  }
}

extension _DoubleView: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    let c0 = context.currentBuilder.buildTree(for: content.0, in: context)
    let c1 = context.currentBuilder.buildTree(for: content.1, in: context)

    return _MultipleLines(other: [
      c0, c1,
    ])
  }
}
