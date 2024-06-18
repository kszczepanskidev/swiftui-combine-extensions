extension View {
    /// Hides view based on the given flag value.
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide { hidden() } else { self }
    }

    /// Apply inner shadow to the `View`.
    ///
    /// - Parameters:
    ///   - shape: Shape used to mask the shadow.
    ///   - angle: Angle at which shadow should be cast. Defaults to `0` degrees.
    ///   - color: Color of the shadow. Defaults to `primaryBlack`.
    ///   - radius: Size of the shadow.
    ///   - blur: Radius of blur that will be applied to the shadow.
    /// - Returns: `View` with applied inner shadow overlay.
    func innerShadow<ShadowShape: Shape>(
        using shape: ShadowShape,
        angle: Angle = .zero,
        color: Color = Asset.Colors.primaryBlack.colorView,
        radius: CGFloat,
        blur: CGFloat
    ) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi.half))
        let finalY = CGFloat(sin(angle.radians - .pi.half))
        return overlay(
            shape
                .stroke(color, lineWidth: radius)
                .offset(x: finalX * radius * 0.6, y: finalY * radius * 0.6)
                .blur(radius: blur)
                .mask(shape)
        )
    }

    /// Positions this view within an invisible frame with the specified square size.
    ///
    /// - Parameters:
    ///   - side: A fixed square side for the resulting view. If `side` is `nil`,
    ///             the resulting view assumes this view's sizing behavior.
    ///   - alignment: The alignment of this view inside the resulting view.
    ///                It applies if this view is smaller than the size given by the resulting frame.
    /// - Returns: `View` with fixed square dimensions of `side`, for non-`nil` value.
    @inlinable func frame(side: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        frame(width: side, height: side, alignment: alignment)
    }

    /// Positions this view within an invisible frame with the specified square size.
    ///
    /// - Parameters:
    ///   - size: A size which configure sides of view.
    ///   - alignment: The alignment of this view inside the resulting view.
    ///                It applies if this view is smaller than the size given by the resulting frame.
    /// - Returns: `View` with fixed square.
    @inlinable func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    /// Helper function that adds both horizontal and vertical padding to the `View`.
    ///
    /// - Parameters:
    ///   - horizontal: horizontal padding to be applied.
    ///   - vertical: vertical padding to be applied.
    /// - Returns: `View` with applied vertical and horizontal padding.
    func padding(horizontal: CGFloat, vertical: CGFloat) -> some View {
        padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }

    /// Helper function that adds different top and bottom paddings to the `View`.
    ///
    /// - Parameters:
    ///   - top: top padding to be applied.
    ///   - bottom: bottom padding to be applied.
    /// - Returns: `View` with applied top and bottom padding.
    func padding(top: CGFloat, bottom: CGFloat) -> some View {
        padding(.top, top)
            .padding(.bottom, bottom)
    }

    /// Layers a secondary view in front of this view with conditional binding.
    ///
    /// - Parameters:
    ///   - overlay: The view to layer in front of this view.
    ///   - binding: `Binding` to a flag handling showing and hiding of the overlay.
    ///   - alignment: The alignment for overlay in relation to this view. Defaults to `.center`.
    /// - SeeAlso: View.overlay(_: alignment)
    @inlinable func overlay<Overlay>(
        _ overlay: Overlay,
        binding: Binding<Bool>,
        alignment: Alignment = .center
    ) -> some View where Overlay: View {
        self.overlay(
            ZStack {
                if binding.wrappedValue { overlay }
            },
            alignment: alignment)
    }

    /// Configures `View` for handling tap gestures.
    /// Required to add gestures to containers like `H/V/ZStack`.
    func wrapForTapGesture(action: @escaping () -> Void) -> some View {
        contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}