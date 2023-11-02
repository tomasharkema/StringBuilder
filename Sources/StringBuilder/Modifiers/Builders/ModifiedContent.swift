
public struct ModifiedContent</*Content,*/ Modifier> {
    public typealias Content = any StringBuildable
    // public typealias Body = Never

    private let content: Content
    private let modifier: Modifier

    public init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedContent : StringBuildable where 

Modifier : StringModifier
// Modifier.Content: StringBuildable,
// Modifier.Body: StringBuildable,
// Content == Modifier.Content
{
    public var lines: [String] {
        modifier.body(content: content).lines
    }
}

// extension ModifiedContent : PartialBuilable 
// where 
// // Content: PartialBuilable,
//  Modifier : StringModifier, 
// //  Modifier.Content: PartialBuilable,
// Modifier.Body: PartialBuilable,
// Content == Modifier.Content {
//     public var part: String {
//         modifier.body(content: content).part
//     }
// }

// extension ModifiedContent : StringBuildable where Content : StringBuildable, Modifier : StringModifier {
//     public var body: ModifiedContent<Content, Modifier>.Body { 
        
//      }
// }