@testable import StringBuilder

struct TesterBase: StringView {
  var body: some StringView {
    Group {
      Line("HELLO")
      Line("HELLO")
    }.textColor(.red)
  }
}

struct TesterTuple: StringView {
  var body: some StringView {
    Line("HELLO")
    Line("HELLO")
  }
}

struct TesterFor: StringView {
  var body: some StringView {
    for string in ["a", "b"] {
      Line(string)
      Indented {
        Line("HELLO")
      }
    }
  }
}

struct TesterMixed: StringView {
  var body: some StringView {
    Line("HELLO")
    "HELLO"
    Appending {
      "HELLO"
      Partial("HELLO")
    }
  }
}

struct TesterEnv: StringView {
  var body: some StringView {
    TesterEnvView()
  }
}

struct TesterEnvView: StringView {
  var body: some StringView {
    Paragraph {
      Line("HELLO")
      Line("HELLO")
      Line("HELLO")
    }
    Line("HELLO")
    Paragraph {
      PrintAnsiEnabledView()
      Line("HELLO").bold()
      Line("HELLO")
    }
    .bold()
    Line("HELLO")
  }
    var descriptionBuilder: some StringView {
    body
  }

  var debugDescriptionBuilder: some StringView {
    body
  }
}



struct PrintAnsiEnabledView: StringView {
  @Environment(\.ansiEnabled)
  var ansiEnabled

  var body: some StringView {
    if ansiEnabled {
      Line("ANSI ENABLED")
    } else {
      Line("ANSI DISABLED")
    }
  }
    var descriptionBuilder: some StringView {
    body
  }

  var debugDescriptionBuilder: some StringView {
    body
  }
}

struct TesterInherited: StringView {
  var body: some StringView {
    List(separator: " ") {
      Partial("A")
      List(separator: ":") {
        Partial("B")
        Partial("C")
      }
      Partial("D")
    }
  }
}


struct TesterCustomWrapper<T: StringView>: CustomStringBuilderConvertible, CustomDebugStringBuilderConvertible {
  let content: T

  init(content: T) {
    self.content = content
  }

  var descriptionBuilder: some StringView {
    content
  }

  var debugDescriptionBuilder: some StringView {
    content
  }
}
