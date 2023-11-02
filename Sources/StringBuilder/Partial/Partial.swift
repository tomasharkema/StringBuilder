//
//  Partial.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct Partial {
  public let part: String

  public init(_ part: String) {
    self.part = part
  }
}

public protocol PartialBuilable {
  var part: String { get }
}

extension Partial: PartialBuilable {
  // public var part: String {
  //   value
  // }
}
