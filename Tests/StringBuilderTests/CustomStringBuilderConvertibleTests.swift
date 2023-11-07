import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class CustomStringBuilderConvertibleTests: XCTestCase {
  @Parametrize(input: [TesterBase(), TesterTuple(), TesterMixed(), TesterEnv(), PrintAnsiEnabledView()])
  func testDescription(input tester: some StringView) {
    let wrapper = TesterCustomWrapper(content: tester)
    let desc = wrapper.description
    assertString(of: desc)
    let view = wrapper.descriptionBuilder
    assertStringView(view: view)
  }
}
