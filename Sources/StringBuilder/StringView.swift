
public protocol StringView: StringBuildable {
  // @StringBuilder
  // var body: [any StringBuildable] { get }

  // associatedtype Convertible

  @StringBuilder
  var body: [any StringBuildable] { get }
  // var body: Self.Convertible { get }
}

public extension StringView {
  var lines: [String] {
    body.flatMap(\.lines)
  }
}

public protocol LineView: PartialBuilable {
  @PartialBuilder
  var body: [any PartialBuilable] { get }
}

public extension LineView {
  var part: String {
    body.map(\.part).joined()
  }
}
