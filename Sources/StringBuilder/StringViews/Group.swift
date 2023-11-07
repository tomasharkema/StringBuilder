import Foundation

public struct Group<Content: StringView>: StringView {
  let partialResult: Content

  public init(@StringBuilder _ content: () -> Content) {
    let string = content()

    partialResult = string
  }
}

extension Group: TreeBuildingView {
  func buildTree(
    in context: TreeStateContext
  ) -> any StringBuildable {
    let parts = partialResult
    return context.currentBuilder.buildTree(for: parts, in: context)
  }
}
