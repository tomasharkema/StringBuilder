//
//  List.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct List: PartialBuilable {
  private let separator: String
  private let parts: () -> [any PartialBuilable]

  public init(separator: String, @PartialBuilder _ handler: @escaping () -> [any PartialBuilable]) {
    self.separator = separator
    parts = handler
  }

  public var part: String {
    parts().map(\.part).joined(separator: separator)
  }
}

extension List: StringBuildable {
  public var lines: [String] {
    [part]
  }
}
