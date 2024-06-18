extension Publishers {

    /// Publisher of keyboard height changes.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

/// Modifier adjusting bottom padding based on current keyboard height.
private struct KeyboardAdaptiveModifier: ViewModifier {

    // MARK: Properties

    @State private var keyboardHeight: CGFloat = 0

    // MARK: Layout

    // - SeeAlso: ViewModifier.body(content:)
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { keyboardHeight = $0 }
    }
}

extension View {

    /// Apply `Keyboard Adaptive Modifier` to the view.
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptiveModifier())
    }
}