// swiftlint:disable:next type_name
struct _MultipleLines: StringBuildable {
  let parts: [[StringBuildableElement]]

  init(lines: [[StringBuildableElement]]) {
    let flattened = lines.map { $0 }
    parts = flattened
  }

  init(lines: [StringBuildableElement]) {
    parts = [lines]
  }

  init(other: [any StringBuildable]) {
    let flattened = other.flatMap(\.lines)
    parts = flattened
  }

  var lines: [[StringBuildableElement]] {
    let array: [[StringBuildableElement]] = Array {
      for part in parts {
        Array {
          for element in part {
            element
          }
//          if let last = part.last, last.value != "\n" {
//            StringBuildableElement(value: "\n", modifiers: [])
//          }
        }
      }
    }
    let flattened = array.joined(by: .newline) // .flatMap { $0 }
    let arr = Array(flattened)
    return [arr]
  }
}
