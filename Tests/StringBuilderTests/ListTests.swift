import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class ListTests: XCTestCase {
  @Parametrize(input: [
    TesterBase(),
    TesterTuple(),
    TesterMixed(),
    TesterEnv(),
    PrintAnsiEnabledView(),
  ])
  func testList(input tester: any StringView) {
    let test = LocalTester(content: tester)
    assertStringView(view: test)
  }
}

private struct LocalTester: StringView {
  let content: any StringView

  var body: some StringView {
    List(separator: " ") {
      List(separator: " ") {
        content
        content
        Partial("DERP").bold()
      }
      Partial("DERP").bold(false)
    }
  }
}
