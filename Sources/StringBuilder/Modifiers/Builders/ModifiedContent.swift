
public struct ModifiedContent<Content: StringView, Modifier: StringModifier> {
  let content: Content
  let modifier: Modifier

  public init(content: Content, modifier: Modifier) {
    self.content = content
    self.modifier = modifier
  }
}

extension ModifiedContent: StringView where Modifier: StringModifier {
  public typealias Body = Never
}

extension ModifiedContent: TreeBuildingView where Modifier: StringModifier {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    let mod = modifier as any StringModifier
    let newContext = context.currentBuilder.apply(modifier: mod, in: context)

    let body = modifier.body(content: content)
    return newContext.currentBuilder.buildTree(for: body, in: newContext)
  }
}
