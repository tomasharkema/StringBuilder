import ANSIEscapeCode
// import CaseAccessors
import IdentifiedEnumCases

// @CaseAccessors
@IdentifiedEnumCases
enum Modifier: Equatable {
  case bold(enabled: Bool)
  case textColor(TextColor?)
  case indented(String)
  case maxWidth(Int?)
}
