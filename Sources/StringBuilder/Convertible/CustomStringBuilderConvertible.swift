//
//  CustomStringBuilderConvertible.swift
//
//
//  Created by Tomas Harkema on 21/08/2023.
//

import Foundation

public protocol CustomStringBuilderConvertible: CustomStringConvertible {
  @StringBuilder
  var descriptionBuilder: [any StringBuildable] { get }
}

public extension CustomStringBuilderConvertible {
  var description: String {
    descriptionBuilder.string
  }
}

public protocol CustomDebugStringBuilderConvertible: CustomDebugStringConvertible {
  @StringBuilder
  var debugDescriptionBuilder: [any StringBuildable] { get }
}

public extension CustomDebugStringBuilderConvertible {
  var debugDescription: String {
    debugDescriptionBuilder.string
  }
}
