
extension [any StringBuildable] {
  public var lines: [String] {
    let strings = flatMap { element in
      let stringValue = element.lines
      return stringValue
    }
    return strings
  }

  public var string: String {
    lines.joined(separator: "\n")
  }
}
