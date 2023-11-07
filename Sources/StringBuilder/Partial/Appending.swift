import ServiceContextModule

public struct Appending: StringView {
  private let parts: () -> [any PartialBuilable]

  public init(@PartialBuilder _ handler: @escaping () -> [any PartialBuilable]) {
    parts = handler
  }

  public var body: some StringView {
    List(separator: "") {
      parts()
    }
  }
}
