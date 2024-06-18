/// `Preference Key` used for getting view height.
private struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

/// Modifier to determine view height.
private struct HeightModifier: ViewModifier {

    // MARK: Properties

    @Binding var height: CGFloat

    // - SeeAlso: ViewModifier.body(content:)
    func body(content: Content) -> some View {
        VStack {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size.height)
                    }
                )
        }
        .onPreferenceChange(SizePreferenceKey.self) { value in
            height = value
        }
    }
}

extension View {

    /// Show `No connection` banner.
    ///
    /// - Parameters:
    ///   - size: `Binding` to the view size.
    func heightModifier(height: Binding<CGFloat>) -> some View {
        modifier(HeightModifier(height: height))
    }
}