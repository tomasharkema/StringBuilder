import ServiceContextModule

protocol TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable
}

public extension StringView {
  var string: String {
    let context = TreeStateContext.default.withAutomatic()
    return StringTreeBuilder.default.buildTree(
      for: self,
      in: context
    ).string(context: context)
  }

  var ansiString: String {
    let context = TreeStateContext.default.withAnsi(true)
    return StringTreeBuilder.default.buildTree(for: self, in: context).string(context: context)
  }

  var unformattedString: String {
    let context = TreeStateContext.default.withAnsi(false).withFormatting(false)
    return StringTreeBuilder.default.buildTree(for: self, in: context).string(context: context)
  }
}

final class StringTreeBuilder {
  static let `default` = StringTreeBuilder()

  func buildTree(
    for view: some StringView,
    in context: TreeStateContext
  ) -> any StringBuildable {
    var serviceContext = ServiceContext.current ?? ServiceContext.topLevel
    serviceContext[ContextLocalKey.self] = context

    return ServiceContext.$current.withValue(serviceContext) {
//      print("BUILDING FOR \(type(of: view))")
      if let treeBuildingView = view as? any TreeBuildingView {
        return treeBuildingView.buildTree(in: context)
      }

      return DynamicElementNode(view: view).buildChild(in: context)
    }
  }

  func buildTree(for view: Empty, in _: TreeStateContext) -> any StringBuildable {
    view
  }

  func apply(
    modifier: some StringModifier,
    in context: TreeStateContext
  ) -> TreeStateContext {
    switch modifier {
    case let bold as BoldLine:
      applyBoldLine(modifier: bold, in: context)

    case let color as LineColor:
      applyColorLine(modifier: color, in: context)

    default:
      context
    }
  }

  func applyBoldLine(
    modifier: BoldLine,
    in context: TreeStateContext
  ) -> TreeStateContext {
    context.withBold(modifier.active)
  }

  func applyColorLine(
    modifier: LineColor,
    in context: TreeStateContext
  ) -> TreeStateContext {
    context.withTextColor(modifier.color)
  }
}

final class DynamicElementNode<Content: StringView> {
  private let view: Content

  init(view: Content) {
    self.view = view
  }

  func buildChild(in context: TreeStateContext) -> any StringBuildable {
    context.currentBuilder.buildTree(for: view.body, in: context)
  }
}
