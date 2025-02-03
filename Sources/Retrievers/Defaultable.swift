public protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Array: Defaultable {
    public static var defaultValue: Array<Element> { [] }
}

extension Optional: Defaultable {
    public static var defaultValue: Optional<Wrapped> { nil }
}
