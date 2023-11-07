import ServiceContextModule

public protocol StringView {
  associatedtype Body: StringView

  @StringBuilder
  var body: Self.Body { get }
}

public extension StringView {
  var body: any StringView {
    (body as Body as any StringView) as (any StringView)
  }
}

public protocol LineView: PartialBuilable {
  @PartialBuilder
  var body: [any PartialBuilable] { get }
}

extension Never: PartialBuilable {
  public func line(context _: TreeStateContext) -> [PartialBuildElement] {
    fatalError()
  }
}

public extension LineView {
  func line(context: TreeStateContext) -> [PartialBuildElement] {
    let lines = body
    let mapped = lines.flatMap {
      $0.line(context: context)
    }
    return mapped
  }
}
