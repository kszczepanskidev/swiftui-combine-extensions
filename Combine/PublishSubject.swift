/// Wrapper for `Passthrough Subject`  with Failure type locked to `Never`.
final class PublishSubject<Output>: Subject {

    public typealias Failure = Never

    // MARK: Properties

    private let subject = PassthroughSubject<Output, Failure>()

    // MARK: Lifecycle

    /// - SeeAlso: PassthroughSubject.send(subscription:)
    public func send(subscription: Subscription) {
        subject.send(subscription: subscription)
    }

    /// - SeeAlso: PassthroughSubject.receive(subscriber:)
    public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S: Subscriber {
        subject.receive(subscriber: subscriber)
    }

    /// - SeeAlso: PassthroughSubject.send(_:)
    public func send(_ input: Output) {
        subject.send(input)
    }

    /// - SeeAlso: PassthroughSubject.send(completion:)
    public func send(completion: Subscribers.Completion<Failure>) {
        subject.send(completion: completion)
    }

    /// - SeeAlso: PassthroughSubject.send()
    public func send() where Output == Void {
        subject.send()
    }
}
