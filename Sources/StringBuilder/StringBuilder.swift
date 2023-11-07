
@resultBuilder
public enum StringBuilder {
  public typealias Expression = StringView
  public typealias Component = StringView

  public static func buildExpression(_ expression: String) -> Line {
    Line(expression)
  }

  public static func buildExpression<V: StringView>(_ expression: V) -> V {
    expression
  }

  public static func buildExpression<V: StringView>(_ expression: V?) -> _OptionalContent<V> {
    _OptionalContent(expression)
  }

  public static func buildPartialBlock<Content>(first content: Content) -> Content
    where Content: StringView
  {
    content
  }

  public static func buildPartialBlock<C0, C1>(accumulated: C0, next: C1) -> _DoubleView<C0, C1>
    where C0: StringView, C1: StringView
  {
    _DoubleView((accumulated, next))
  }

  public static func buildOptional<V: StringView>(_ component: V?) -> _OptionalContent<V> {
    _OptionalContent(component)
  }

  public static func buildEither<TrueContent: StringView, FalseContent: StringView>(
    first component: TrueContent
  ) -> _ConditionalContent<TrueContent, FalseContent> {
    _ConditionalContent(.true(component))
  }

  public static func buildEither<TrueContent: StringView, FalseContent: StringView>(
    second component: FalseContent
  ) -> _ConditionalContent<TrueContent, FalseContent> {
    _ConditionalContent(.false(component))
  }

  public static func buildArray(_ components: [some StringView]) -> _ArrayView {
    _ArrayView(components)
  }

  public static func buildLimitedAvailability<V: StringView>(_ component: V) -> V {
    component
  }
}
