import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class CustomDebugStringBuilderConvertibleTests: XCTestCase {
  @Parametrize(input: [
    TesterBase(),
    TesterTuple(),
    TesterMixed(),
    TesterEnv(),
    PrintAnsiEnabledView(),
  ])
  func testDescription(input tester: some StringView) {
    let wrapper = TesterCustomWrapper(content: tester)
    let desc = wrapper.debugDescription
    assertString(of: desc)
    let view = wrapper.debugDescriptionBuilder
    assertStringView(view: view)
  }
}
