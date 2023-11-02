//
//  Line.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct Line {
  private var value: String

  public init(_ value: String) {
    self.value = value
  }
}

extension Line: StringBuildable {
  public var lines: [String] {
    [value]
  }
}

extension Line: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.value = value
  }
}
