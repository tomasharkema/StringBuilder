import Foundation

private(set) var defaultTerminal = termios()
private(set) var isNonBlockingMode = false

private let ESC = "\u{1B}" // Escape character (27 or 1B)
private let CSI = ESC + "[" // Control Sequence Introducer

func disableNonBlockingTerminal() {
  // restore default terminal mode
  tcsetattr(STDIN_FILENO, TCSANOW, &defaultTerminal)
  isNonBlockingMode = false
}

func enableNonBlockingTerminal(rawMode: Bool = false) {
  // store current terminal mode
  tcgetattr(STDIN_FILENO, &defaultTerminal)
  atexit(disableNonBlockingTerminal)
  isNonBlockingMode = true

  // configure non-blocking and non-echoing terminal mode
  var nonBlockTerm = defaultTerminal
  if rawMode {
    //! full raw mode without any input processing at all
    cfmakeraw(&nonBlockTerm)
  } else {
    // disable CANONical mode and ECHO-ing input
    nonBlockTerm.c_lflag &= ~tcflag_t(ICANON | ECHO)
    // acknowledge CRNL line ending and UTF8 input
    nonBlockTerm.c_iflag &= ~tcflag_t(ICRNL | IUTF8)
  }

  // enable new terminal mode
  tcsetattr(STDIN_FILENO, TCSANOW, &nonBlockTerm)
}

// request terminal info using ansi esc command and return the response value
func ansiRequest(_ command: String, endChar: Character) -> String {
  // store current input mode
  let nonBlock = isNonBlockingMode
  if !nonBlock { enableNonBlockingTerminal() }

  // send request
  write(STDOUT_FILENO, command, command.count)

  // read response
  var res = ""
  var key: UInt8 = 0
  repeat {
    read(STDIN_FILENO, &key, 1)
    if key < 32 {
      res.append("^") // replace non-printable ascii
    } else {
      res.append(Character(UnicodeScalar(key)))
    }
  } while key != endChar.asciiValue

  // restore input mode and return response value
  if !nonBlock { disableNonBlockingTerminal() }
  return res
}

public struct ScreenSize {
  public let width: Int
  public let height: Int
}

func isRunningFromXcode() -> Bool {
#if DEBUG
  if let _ = NSClassFromString("XCTest") {
    return true
  }

  if ProcessInfo.processInfo.environment["__CFBundleIdentifier"] == "com.apple.dt.Xcode" {
    return true
  }
#endif
  return false
}

func readScreenSize() -> ScreenSize? {
#if os(iOS)
  return nil
#else
  if isRunningFromXcode() {
    return nil
  }

  if ProcessInfo.processInfo.environment["TERM"] == nil {
    return nil
  }
#endif

  var str = ansiRequest(CSI + "18t", endChar: "t") // returns ^[8;row;colt
  if str.isEmpty { return nil }

  str = String(str.dropFirst(4)) // remove ^[8;
  let del = str.firstIndex(of: ";")!
  let end = str.firstIndex(of: "t")!
  let row = String(str[...str.index(before: del)])
  let col = String(str[str.index(after: del) ... str.index(before: end)])

  return ScreenSize(width: Int(col)!, height: Int(row)!)
}
