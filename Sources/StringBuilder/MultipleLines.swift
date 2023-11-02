//
//  MultipleLines.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct MultipleLines {
  public var lines: [String]

  public init(_ lines: [String]) {
    self.lines = lines
  }
}

extension MultipleLines: StringBuildable {}

// extension MultipleLines: StringView {
//   public var body: some StringView {
//     fatalError()
//   }
// }
