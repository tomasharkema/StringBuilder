
// swiftlint:disable:next type_name
public struct _ConditionalContent<TrueContent: StringView, FalseContent: StringView>: StringView {
  public typealias Body = Never

  let content: Conditional

  init(_ content: Conditional) {
    self.content = content
  }

  enum Conditional {
    case `true`(TrueContent)
    case `false`(FalseContent)
  }
}

extension _ConditionalContent: TreeBuildingView {
  func buildTree(
    in context: TreeStateContext
  ) -> any StringBuildable {
    switch content {
    case let .true(view):
      context.currentBuilder.buildTree(for: view, in: context)
    case let .false(view):
      context.currentBuilder.buildTree(for: view, in: context)
    }
  }
}
