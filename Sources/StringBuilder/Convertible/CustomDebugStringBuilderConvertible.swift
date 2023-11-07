
public protocol CustomDebugStringBuilderConvertible: CustomDebugStringConvertible {
  associatedtype DebugDescriptionContent: StringView
  @StringBuilder
  var debugDescriptionBuilder: DebugDescriptionContent { get }
}

public extension CustomDebugStringBuilderConvertible {
  var debugDescription: String {
    debugDescriptionBuilder.string
  }
}
