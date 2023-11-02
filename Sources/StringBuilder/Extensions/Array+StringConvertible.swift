
public extension [any StringBuildable] {
  var lines: [String] {
    let strings = flatMap { element in
      let stringValue = element.lines
      return stringValue
    }
    return strings
  }

  var string: String {
    lines.joined(separator: "\n")
  }
}
