import SnapshotTesting
@testable import StringBuilder
import XCTest
import XCTestParametrizedMacro

final class GroupTests: XCTestCase {
  @Parametrize(input: [TesterBase(), TesterTuple(), TesterMixed(), TesterEnv(), PrintAnsiEnabledView()])
  func testGroup(input tester: some StringView) {
    let group = Grouper(content: tester)
    assertStringView(view: group)
  }
}

private struct Grouper<T: StringView>: StringView {
  let content: T

  init(content: T) {
    self.content = content
  }

  var body: some StringView {
    Group {
      content
      content
    }
  }
}
