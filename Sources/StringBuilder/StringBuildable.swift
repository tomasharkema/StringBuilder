import Algorithms
import Foundation

struct StringBuildableElement: Equatable {
  static let newline = StringBuildableElement(value: "\n", modifiers: [:])

  let value: String
  var modifiers = [Modifier.CaseID: Modifier]()

  func build(context: TreeStateContext) -> String {
    var newString = value
    var newModifiers = modifiers
    for (key, modifier) in context.modifiers {
      newModifiers[key] = modifier
    }

    for (_, modifier) in newModifiers {
      switch modifier {
      case let .bold(enabled: enabled):
//        break
        if enabled, context.isAnsiEnabled {
          newString = newString.boldOutput
        }

      case let .textColor(color):
//        break
        if let color, context.isAnsiEnabled {
          newString = newString.color(color)
        }

      case let .indented(character):
        if context.isFormattingEnabled {
          newString = "\(character)\(newString)"
        }

      case .maxWidth:
        // do as last
        break
      }
    }

    return newString
  }
}

protocol StringBuildable {
  var lines: [[StringBuildableElement]] { get }
}

struct EmptyBuilder: StringBuildable {
  let lines: [[StringBuildableElement]] = []
}

extension StringBuildable {
  func splitLine(
    line: StringBuildableElement, paddings: [String], width: Int,
    currentWidth: Int
  ) -> [StringBuildableElement] {
    let padding = paddings.joined()
    var result = [StringBuildableElement]()

    let currentElement = line.value.prefix(currentWidth)
    let initialElement = StringBuildableElement(
      value: String(currentElement),
      modifiers: line.modifiers
    )

    let lineRest = line.value.dropFirst(currentWidth)
    let restSplitted = lineRest.chunks(ofCount: width)
    let elements = restSplitted.flatMap {
      [
        StringBuildableElement(value: "\(padding)\($0)", modifiers: line.modifiers),
        StringBuildableElement.newline,
      ]
    }

    result.append(contentsOf: [
      initialElement,
      StringBuildableElement.newline,
    ])
    result.append(contentsOf: elements)
    return result
  }

  func split(
    lines: [StringBuildableElement], paddings: [String],
    width: Int
  ) -> [StringBuildableElement] {
    var currentCount = 0
    var result = [StringBuildableElement]()

    for line in lines {
      let count = line.value.count
      let updatedCount = currentCount + count

      if updatedCount > width {
        let splitted = splitLine(
          line: line,
          paddings: paddings,
          width: width,
          currentWidth: currentCount
        )
        result.append(contentsOf: splitted)
        currentCount = 0

      } else {
        currentCount = updatedCount

        result.append(line)
      }
    }

    return result
  }

//  func checkParagraph(
//    context: TreeStateContext,
//    line: [StringBuildableElement]
//  ) -> [StringBuildableElement] {
  ////    let modifiers = line.mo
  ////    let maxWidth = modifiers[.maxWidth]
//
//    guard let maxWidth, context.isFormattingEnabled else {
//      return line
//    }
//
//    let byNewline = line.split(separator: .newline)
//
//    let new = byNewline.map { part in
//
//      let paddings = part.flatMap { $0.modifiers.compactMap(\.indented) }
//      let padding = paddings.joined()
//
//      let extraIndent = "  "
//      let widthLeft = maxWidth - padding.count - extraIndent.count
//
//      let splitted = split(lines: Array(part), paddings: paddings, width: widthLeft)
//      return splitted
//    }
//
//    let join = new.joined(by: .newline)
//    let arr = Array(join)
//    return arr
//  }

  func string(context: TreeStateContext) -> String {
    let built = lines.map { line in
      let paragraphChecked = line // checkParagraph(context: context, line: line)
      let mapped = paragraphChecked.map { seg in
        let built = seg.build(context: context)
        return built
      }
      let joined = mapped.joined(separator: "")
      return joined
    }
    let join = built.joined(separator: "")
    return join
  }
}
