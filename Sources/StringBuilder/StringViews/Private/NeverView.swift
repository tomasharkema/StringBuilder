
extension Never: StringView {
  public var body: Never {
    fatalError("no body in Never")
  }
}

public extension StringView where Body == Never {
  var body: Never { fatalError("no body in \(type(of: self))") }
}
