import Algorithms
import Foundation

public struct Indented<Content: StringView>: StringView {
  let character: String

  let partialResult: () -> Content

  public init(
    character: String = "  ",
    @StringBuilder _ content: @escaping () -> Content
  ) {
    self.character = character
    partialResult = content
  }
}

extension Indented: TreeBuildingView {
  func buildTree(in context: TreeStateContext) -> any StringBuildable {
    let children = partialResult()
    let lines = context.currentBuilder.buildTree(for: children, in: context)

    let newLines: [[StringBuildableElement]] = Array {
      for line in lines.lines {
        let splitted = line.split {
          $0 == .newline
        }
        for split in splitted {
          Array {
            StringBuildableElement(value: "", modifiers: [.indented: .indented(character)])
            for element in split {
              element
            }
          }
        }
      }
    }
    return _MultipleLines(lines: newLines)
  }
}
