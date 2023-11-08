import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class StringColorTests: XCTestCase {
  @Parametrize(input: [
    TesterBase(),
    TesterTuple(),
    TesterMixed(),
    TesterEnv(),
    IndentedColorTester(),
  ])
  func testStringColor(input tester: any StringView) {
    assertStringView(view: tester)
  }
}

private struct IndentedColorTester: StringView {
  var body: some StringView {
    Indented {
      Appending {
        "at: "
        "DERP!"
      }
    }
    .textColor(.red)
  }
}
