private struct RoundedCorners: Shape {

    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {

    /// Clip rounded corners for given edges.
    ///
    /// - Parameters:
    ///   - radius: radius of rounded corners.
    ///   - corners: collection of corners that should be rounded. Defaults to '.allCorners'.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}
