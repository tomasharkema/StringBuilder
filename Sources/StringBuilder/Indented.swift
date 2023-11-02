//
//  Indented.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Algorithms
import Foundation

public struct Indented {
  private let character: String

  private var partialResult: [any StringBuildable]

  public init(character: String = "  ", @StringBuilder _ content: () -> [any StringBuildable]) {
    self.character = character
    let string = content()

    partialResult = string
  }
}

extension Indented: StringBuildable {
  public var lines: [String] {
    let flattened = partialResult //flatten(in: partialResult)
    let eles = flattened.flatMap {
      let svalue = $0.lines
      let mapped = svalue.map {
        "\(character)\($0)"
      }
      return mapped
    }
    return eles
  }
}
