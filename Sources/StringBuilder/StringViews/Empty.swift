
public struct Empty: StringView {
  let lines: [[StringBuildableElement]] = [[.init(value: "", modifiers: [:])]]

  public init() {}
}

extension Empty: StringBuildable {}

extension Empty: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    context.currentBuilder.buildTree(for: self, in: context)
  }
}
