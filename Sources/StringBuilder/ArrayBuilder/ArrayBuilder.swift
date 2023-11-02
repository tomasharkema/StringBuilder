//
//  ArrayBuilder.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

@resultBuilder
public enum ArrayBuilder<T> {
  public static func buildBlock() -> [T] { [] }
  public static func buildExpression(_ expression: T) -> [T] { [expression] }
  public static func buildExpression(_ expression: T?) -> [T] { [expression].compactMap { $0 } }
  public static func buildExpression(_ expression: [T]) -> [T] { expression }
  public static func buildBlock(_ components: [T]...) -> [T] { components.flatMap { $0 } }
  public static func buildArray(_ components: [[T]]) -> [T] { components.flatMap { $0 } }
  public static func buildOptional(_ component: [T]?) -> [T] { component ?? [] }
  public static func buildEither(first component: [T]) -> [T] { component }
  public static func buildEither(second component: [T]) -> [T] { component }
  public static func buildLimitedAvailability(_ component: [T]) -> [T] { component }
}

public extension Array {
  init(@ArrayBuilder<Element> builder: () -> [Element]) { self = builder() }
}
