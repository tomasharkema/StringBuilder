// import Foundation
//
// @resultBuilder
// public enum SequenceBuilder<T> {
//
//  public typealias Component = any Sequence<T>
//
//  public static func buildBlock() -> Component {
//    BuilderIterator(elements: [])
//  }
//  public static func buildExpression(_ expression: @autoclosure @escaping () -> T) -> Component {
//    BuilderIterator(elements: [expression])
//  }
//  public static func buildExpression(_ expression: @autoclosure @escaping () -> T?) -> Component {
////    [expression].compactMap { $0 }
//    let lazy: any Sequence<() -> T> = [expression].lazy.flatMap {
//      return {
//
//      }
//    }
//    return BuilderIterator(lazy)
//  }
//  public static func buildExpression(_ expression: @autoclosure () -> [T]) -> Component {
//    expression }
//  public static func buildBlock(_ components: @autoclosure () -> [T]...) -> Component {
//    components.flatMap { $0 } }
//  public static func buildArray(_ components: @autoclosure () -> [[T]]) -> Component {
//    components.flatMap { $0 } }
//  public static func buildOptional(_ component: @autoclosure () -> [T]?) -> Component {
//    component ?? [] }
//  public static func buildEither(first component: @autoclosure () -> [T]) -> Component {
//    component }
//  public static func buildEither(second component: @autoclosure () -> [T]) -> Component {
//    component }
//  public static func buildLimitedAvailability(_ component: @autoclosure () -> [T]) -> Component {
//    component
//  }
//
// }
//
// struct BuilderIterator<Element>: Sequence {
//  let elements: any IteratorProtocol<() -> Element>
//
//  struct Iterator: IteratorProtocol {
//    var helper: any IteratorProtocol<() -> Element>
//
//    mutating func next() -> Element? {
//      helper.next()?()
//    }
//  }
//
//  init(elements: [() -> Element]) {
//    self.elements = elements.makeIterator()
//  }
//  init(elements: any Sequence<() -> Element>) {
//    self.elements = elements.makeIterator()
//  }
//
//  func makeIterator() -> Iterator {
//    Iterator(helper: elements)
//  }
// }
//
// public extension Sequence {
//  init(@SequenceBuilder<Element> builder: () -> [Element]) { self = builder() }
// }
