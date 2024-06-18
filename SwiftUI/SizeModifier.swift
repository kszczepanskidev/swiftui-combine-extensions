/// `Preference Key` used for getting view size.
private struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

/// Modifier to determine view size.
private struct SizeModifier: ViewModifier {

    // MARK: Properties

    @Binding var size: CGSize

    // - SeeAlso: ViewModifier.body(content:)
    func body(content: Content) -> some View {
        VStack {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
        }
        .onPreferenceChange(SizePreferenceKey.self) { size = $0 }
    }
}

extension View {

    /// Show `No connection` banner.
    ///
    /// - Parameters:
    ///   - size: `Binding` to the view size.
    func sizeModifier(size: Binding<CGSize>) -> some View {
        modifier(SizeModifier(size: size))
    }
}
