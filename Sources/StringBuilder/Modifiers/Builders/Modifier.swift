
struct Map: StringView {
    private let content: any StringBuildable
    private let mapper: (String) -> String
    
    init(_ content: any StringBuildable, _ mapper: @escaping (String) -> String) {
        self.content = content
        self.mapper = mapper
    }

    var body: [any StringBuildable] {
        MultipleLines(content.lines.map {
            mapper($0)
        })
    }
}