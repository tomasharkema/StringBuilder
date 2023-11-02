
@resultBuilder
public enum StringBuilder {
  public typealias Expression = StringBuildable

  public typealias Component = [any StringBuildable]

  public static func buildExpression(_ expression: any CustomStringBuilderConvertible)
    -> Component
  {
    expression.descriptionBuilder
  }

  public static func buildExpression(_ expression: String) -> Component {
    [Line(expression)]
  }

  public static func buildExpression(_ expression: [any Expression]) -> Component {
    expression
  }

  public static func buildExpression(_ expression: any Expression) -> Component {
    [expression]
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
