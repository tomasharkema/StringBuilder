import Foundation
import SnapshotTesting
import StringBuilder

func assertString(
  of string: @autoclosure () -> String,

  record recording: Bool = false,
  timeout: TimeInterval = 5,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
) {
  assertSnapshot(
    of: string().split(separator: "\n"), as: .dump, record: recording,
    timeout: timeout, file: file, testName: testName, line: line
  )
}

func assertJson(
  of string: @autoclosure () -> any Encodable,
  record recording: Bool = false,
  timeout: TimeInterval = 5,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
) {
  assertSnapshot(
    of: string(), as: .json, record: recording,
    timeout: timeout, file: file, testName: testName, line: line
  )
}

func assertStringView(
  view: @autoclosure () -> any StringView,
  record recording: Bool = false,
  timeout: TimeInterval = 5,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
) {
  assertString(
    of: view().ansiString,
    record: recording,
    timeout: timeout,
    file: file,
    testName: testName,
    line: line
  )
  assertString(
    of: view().string,
    record: recording,
    timeout: timeout,
    file: file,
    testName: testName,
    line: line
  )
  assertString(
    of: view().unformattedString,
    record: recording,
    timeout: timeout,
    file: file,
    testName: testName,
    line: line
  )
}
