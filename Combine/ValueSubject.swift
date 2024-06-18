/// Wrapper for `Current Value Subject`  with Failure type locked to `Never`.
public final class ValueSubject<Output>: Subject {

    public typealias Failure = Never

    // MARK: Properties

    /// - SeeAlso: CurrentValueSubject.value
    var value: Output {
        get { subject.value }
        set(value) { subject.value = value }
    }

    private let subject: CurrentValueSubject<Output, Failure>

    // MARK: Initializers

    /// - SeeAlso: CurrentValueSubject.init(_:)
    init(_ value: Output) {
        subject = CurrentValueSubject<Output, Failure>(value)
    }

    // MARK: Lifecycle

    /// - SeeAlso: CurrentValueSubject.send(subscription:)
    public func send(subscription: Subscription) {
        subject.send(subscription: subscription)
    }

    /// - SeeAlso: CurrentValueSubject.receive(subscriber:)
    public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S: Subscriber {
        subject.receive(subscriber: subscriber)
    }

    /// - SeeAlso: CurrentValueSubject.send(_:)
    public func send(_ input: Output) {
        subject.send(input)
    }

    /// - SeeAlso: CurrentValueSubject.send(completion:)
    public func send(completion: Subscribers.Completion<Failure>) {
        subject.send(completion: completion)
    }
}