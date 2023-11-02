//
//  PartialBuilder.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

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

  //  public static func buildExpression(_ expression: any CustomStringBuilderConvertible) -> Component {
  //    buildExpression(expression.descriptionBuilder.map(\.string).joined(separator: "\n"))
  //  }

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
