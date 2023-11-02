//
//  StringConvertible.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public protocol StringBuildable {
  var lines: [String] { get }
}

public extension StringBuildable {
  var string: String {
    lines.joined(separator: "\n")
  }

 var description: String {
    string
  }

 var debugDescription: String {
    string
  }
}
