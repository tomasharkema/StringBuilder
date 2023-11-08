import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class PartialCombinedTests: XCTestCase {
  @Parametrize(input: [
    TesterBase(),
    TesterTuple(),
    TesterMixed(),
    TesterEnv(),
    PrintAnsiEnabledView(),
  ])
  func testPartialCombined(input tester: some StringView) {
    let test = PartialCombinedTester(content: tester)
    assertStringView(view: test)
  }
}

private struct PartialCombinedTester<T: StringView>: StringView {
  let content: T
  var body: some StringView {
    List(separator: " ") {
      List(separator: " ") {
        Partial("DERP").bold()
        content
      }
      Partial("DERP").bold(false)
    }
  }
}
