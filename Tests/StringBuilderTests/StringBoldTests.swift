// import SnapshotTesting
// @testable import StringBuilder
// import XCTest
// import XCTestParametrizedMacro

// final class StringBoldTests: XCTestCase {
//   @Parametrize(input: [
//     TesterBase(),
//     TesterTuple(),
//     TesterMixed(),
//     TesterEnv(),
//     PrintAnsiEnabledView(),
//   ])
//   func testStringBold(input tester: some StringView) {
//     let test = BoldTester(content: tester)
//     assertStringView(view: test)
//   }
// }

// private struct BoldTester<T: StringView>: StringView {
//   let content: T

//   var body: some StringView {
//     Group {
//       content
//     }.bold()
//   }
// }
