
// swiftlint:disable large_tuple function_body_length

@available(macOS 14, iOS 17, *)
// swiftlint:disable:next type_name
public struct _TupleView<each Content>: StringView {
  public typealias Body = Never

  let content: (repeat each Content)

  init(_ content: (repeat each Content)) {
    self.content = content
  }
}

@available(macOS 14, iOS 17, *)
extension _TupleView: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    if let contentCast = content as? (any StringView) {
      return context.currentBuilder.buildTree(for: contentCast, in: context)
    } else
    if let contentCast = content as? (any StringView, any StringView) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(contentCast.0, contentCast.1),
        in: context
      )
    } else
    if let contentCast = content as? (any StringView, any StringView, any StringView) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(contentCast.0, contentCast.1, contentCast.2),
        in: context
      )
    } else
    if let contentCast = content as? (
      any StringView,
      any StringView,
      any StringView,
      any StringView
    ) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(contentCast.0, contentCast.1, contentCast.2, contentCast.3),
        in: context
      )
    } else
    if let contentCast = content as? (
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView
    ) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(contentCast.0, contentCast.1, contentCast.2, contentCast.3, contentCast.4),
        in:
        context
      )
    } else
    if let contentCast = content as? (
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView
    ) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(contentCast.0, contentCast.1, contentCast.2, contentCast.3, contentCast.4,
                        contentCast.5),
        in:
        context
      )
    } else
    if let contentCast = content as? (
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView
    ) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(
          contentCast.0,
          contentCast.1,
          contentCast.2,
          contentCast.3,
          contentCast.4,
          contentCast.5,
          contentCast.6
        ),
        in: context
      )
    } else
    if let contentCast = content as? (
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView,
      any StringView
    ) {
      return context.currentBuilder.buildTree(
        for: _ArrayView(
          contentCast.0,
          contentCast.1,
          contentCast.2,
          contentCast.3,
          contentCast.4,
          contentCast.5,
          contentCast.6,
          contentCast.7
        ),
        in: context
      )
    }

    let typeName = type(of: content)
    print("NO BUILDER FOR \(typeName)")
    fatalError("NO BUILDER FOR \(typeName)")
  }
}

// swiftlint:enable large_tuple function_body_length
