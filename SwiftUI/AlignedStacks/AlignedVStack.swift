/// Helper for creating `VStack` with `VerticalAlignment`.
struct AlignedVStack<Content: View>: View {

    // MARK: Properties

    var verticalAlignment: VerticalAlignment
    var horizontalAlignment: HorizontalAlignment = .center
    var spacing: CGFloat?
    @ViewBuilder let builder: () -> Content

    // MARK: Layout

    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: spacing) {
            if verticalAlignment != .top {
                Spacer()
            }
            builder()
            if verticalAlignment != .bottom {
                Spacer()
            }
        }
    }
}

extension View {

    /// Wraps `View` into `AlignedVStack` with given `VerticalAlignment`.
    func verticalAlignment(_ alignment: VerticalAlignment) -> some View {
        AlignedVStack(verticalAlignment: alignment) { self }
    }
}