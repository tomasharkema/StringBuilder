import ANSIEscapeCode

public protocol StringModifier {
  typealias Content = ViewModifierContent<Self>
  associatedtype Body: StringView
  func body(content: Self.Content) -> Self.Body
}

public extension StringModifier {
  func body(content: any StringView) -> any StringView {
    (body(content: Content(content, modifier: self)) as Body as any StringView) as (any StringView)
  }
}

public extension StringView {
  @inlinable
  func modifier<Modifier>(_ modifier: Modifier) -> ModifiedContent<Self, Modifier> {
    ModifiedContent(content: self, modifier: modifier)
  }
}

public extension StringModifier {
  func body(content: Content) -> some StringView {
    content
  }
}

public struct ViewModifierContent<VM: StringModifier>: StringView {
  public let view: any StringView
  public let modifier: VM

  public init(_ view: any StringView, modifier: VM) {
    self.view = view
    self.modifier = modifier
  }

  public var body: Never {
    fatalError()
  }
}

extension ViewModifierContent: TreeBuildingView {
  func modifier(context: TreeStateContext,
                modifier: EnvironmentKeyWritingModifier<some Any>) -> TreeStateContext
  {
    context.update(modifier: modifier)
  }

  func buildTree(
    in context: TreeStateContext
  ) -> any StringBuildable {
    let content = view
    return context.currentBuilder.buildTree(for: content, in: context)
  }
}
