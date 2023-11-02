//
//  Paragraph.swift
//
//
//  Created by Tomas Harkema on 31/10/2023.
//

import Foundation

public struct Paragraph {
  private let maxWidth = 150
  private let partialResult: [any StringBuildable]

  public init(@StringBuilder _ content: () -> [any StringBuildable]) {
    let string = content()

    partialResult = string
  }
}

extension Paragraph: StringBuildable {
   public var lines: [String] {
    let flattened = partialResult//flatten(in: partialResult)
    let eles = flattened.flatMap {
      let svalue = $0.lines
      let mapped = svalue.flatMap { mapElement in

        let padding = if #available(macOS 13.0, *) {
          if let paddingMatch = mapElement.firstMatch(of: /(?<padding>\s+)(.*)/) {
            String(paddingMatch.output.padding)
          } else {
            ""
          }
        } else {
          ""
        }

        let widthLeft = maxWidth - padding.count

        let chunked = mapElement.split(separator: "\n")
          .flatMap { $0.chunks(ofCount: widthLeft) }
          .enumerated()
          .map { index, string in
            if index == 0 {
              "\(string)"
            } else {
              "\(padding)  \(string)"
            }
          }
        return Array(chunked)
      }
      return mapped
    }
    return eles
  }
}