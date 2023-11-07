import Foundation

public struct Paragraph<Content: StringView>: StringView {
  let maxWidth: Int?
  let content: () -> Content

  public init(maxWidth: Int? = nil, @StringBuilder _ content: @escaping () -> Content) {
    self.maxWidth = maxWidth
    self.content = content
  }
}

extension Paragraph: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    let children = content()
    let lines = context.currentBuilder.buildTree(for: children, in: context)

    let maxWidth = maxWidth ?? context.environment[keyPath: \.screenSize]?.width ?? 150

    let newLines = Array {
      for line in lines.lines {
        for part in line {
          part
        }
        StringBuildableElement(value: "", modifiers: [:]) // .maxWidth(maxWidth)])
      }
    }
    return _MultipleLines(lines: newLines)
  }
}
