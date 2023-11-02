
public protocol StringView: StringBuildable {
  // @StringBuilder
  // var body: [any StringBuildable] { get }

      // associatedtype Convertible



    @StringBuilder 
    var body: [any StringBuildable] {get}
    // var body: Self.Convertible { get }
}

extension StringView {
  public var lines: [String] { 
    body.flatMap(\.lines)
  }
}

public protocol LineView: PartialBuilable {
  @PartialBuilder
  var body: [any PartialBuilable] { get }
}

extension LineView {
  public var part: String { 
    body.map(\.part).joined()
  }
}