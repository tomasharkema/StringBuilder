import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class IndentedTests: XCTestCase {
  @Parametrize(input: [TesterBase(), TesterTuple(), TesterMixed(), TesterEnv(), PrintAnsiEnabledView()])
  func testIndented(input tester: any StringView) {
    assertStringView(view: tester)
  }
}
