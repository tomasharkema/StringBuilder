import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class OptionalContentTests: XCTestCase {
  @Parametrize(input: [
    TesterBase(),
    TesterTuple(),
    TesterMixed(),
    TesterEnv(),
    PrintAnsiEnabledView(),
  ])
  func testOptional(input tester: some StringView) {
    let test = OptionalTester(element: tester)
    assertStringView(view: test)
  }
}

private struct OptionalTester<T: StringView>: StringView {
  let element: T

  init(element: T) {
    self.element = element
  }

  var body: some StringView {
    if true {
      Line("TRUE!")
      element
    }
    if false {
      Line("FALSE!")
    }
  }
}
