import Foundation

// swiftlint:disable:next type_name
struct _ConcatLines: StringBuildable {
  let parts: [[StringBuildableElement]]

  init(lines: [[StringBuildableElement]]) {
    let flattened = lines
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
    parts
  }
}
