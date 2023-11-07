import Foundation

public protocol CustomStringBuilderConvertible: CustomStringConvertible {
  associatedtype DescriptionContent: StringView
  @StringBuilder
  var descriptionBuilder: DescriptionContent { get }
}

public extension CustomStringBuilderConvertible {
  var description: String {
    descriptionBuilder.string
  }
}
