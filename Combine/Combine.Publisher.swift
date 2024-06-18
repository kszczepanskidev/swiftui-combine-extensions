extension Combine.Publisher {

    /// Maps `Output` type to `Void`.
    func asVoid() -> AnyPublisher<Void, Failure> {
        map { _ in () }
            .eraseToAnyPublisher()
    }
}

extension Combine.Publisher where Output: OptionalType {

    /// Unwraps and filters out `nil` elements.
    func filterNil() -> AnyPublisher<Output.Wrapped, Failure> {
        compactMap { $0.value }
            .eraseToAnyPublisher()
    }

    /// Subscribes to first not `nil` element.
    func firstNotNil() -> AnyPublisher<Output, Failure> {
        first { $0.value != nil }
            .eraseToAnyPublisher()
    }
}