import ANSIEscapeCode

public struct LineColor: StringModifier {

    private let color: TextColor

    public init(_ color: TextColor) {
        self.color = color
    }

    public func body(content: any StringBuildable) -> any StringBuildable {
        Map(content) {
             $0.color(color)
        }
    }
}

extension StringBuildable {
    public func color(_ colorr: TextColor) -> any StringBuildable {
        modifier(LineColor(colorr))
    }
}