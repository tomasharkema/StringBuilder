import Foundation

@resultBuilder
public enum PartialBuilder {
  public typealias Expression = PartialBuilable

  public typealias Component = [any PartialBuilable]

  public static func buildExpression(_ expression: String) -> Component {
    [Partial(expression)]
  }

  public static func buildExpression(_ expression: [any Expression]) -> Component {
    expression
  }

  public static func buildExpression(_ expression: any Expression) -> Component {
    [expression]
  }

  @_disfavoredOverload
  public static func buildExpression(_ expression: any StringView) -> Component {
    [_PartialFromStringView(expression)]
  }

  public static func buildBlock(_ components: Component...) -> Component {
    components
      .flatMap {
        $0
      }
  }

  public static func buildOptional(_ component: Component?) -> Component {
    component ?? []
  }

  public static func buildEither(first component: Component) -> Component {
    component
  }

  public static func buildEither(second component: Component) -> Component {
    component
  }

  public static func buildArray(_ components: [Component]) -> Component {
    components
      .flatMap {
        $0
      }
  }
}
