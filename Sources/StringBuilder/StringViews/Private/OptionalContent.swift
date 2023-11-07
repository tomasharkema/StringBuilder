
// swiftlint:disable:next type_name
public struct _OptionalContent<Content: StringView>: StringView {
  public typealias Body = Never

  let content: Content?

  init(_ content: Content?) {
    self.content = content
  }
}

extension _OptionalContent: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    if let content {
      context.currentBuilder.buildTree(
        for: content,
        in: context
      )
    } else {
      EmptyBuilder()
    }
  }
}
