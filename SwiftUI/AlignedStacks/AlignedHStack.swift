/// Helper for creating `HStack` with `HorizontalAlignment`.
struct AlignedHStack<Content: View>: View {

    // MARK: Properties

    var verticalAlignment: VerticalAlignment = .center
    var horizontalAlignment: HorizontalAlignment
    var spacing: CGFloat?
    @ViewBuilder let builder: () -> Content

    // MARK: Layout

    var body: some View {
        HStack(alignment: verticalAlignment, spacing: spacing) {
            if horizontalAlignment != .leading {
                Spacer()
            }
            builder()
            if horizontalAlignment != .trailing {
                Spacer()
            }
        }
    }
}

extension View {

    /// Wraps `View` into `AlignedHStack` with given `HorizontalAlignment`.
    func horizontalAlignment(_ alignment: HorizontalAlignment) -> some View {
        AlignedHStack(horizontalAlignment: alignment) { self }
    }
}