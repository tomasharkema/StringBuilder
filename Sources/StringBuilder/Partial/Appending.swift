//
//  Appending.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct Appending: StringBuildable {

  private let parts: () -> [any PartialBuilable]

  public init(@PartialBuilder _ handler: @escaping () -> [any PartialBuilable]) {
    parts = handler
  }

  public var lines: [String] {
    [parts().map(\.part).joined(separator: " ")]
  }
}
