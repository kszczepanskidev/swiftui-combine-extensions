/// `Preference Key` used for calculating scroll offset in `ScrollView` or `List`.
/// Requires to add two views into hierarchy. One of `scrolling` type on top of the content
/// and one of the `static` as background of `ScrollView` or `List`.
/// Scroll offset can be then calculated based on the frames of those two views.
struct ScrollOffsetPreferenceKey: PreferenceKey {

    // MARK: Types

    enum Constants {
        static let pullThreshold: CGFloat = 120
    }

    /// Available types of view using this pref key.
    enum ViewType: Int {
        case scrolling, `static`
    }

    /// Helper struct that holds `ViewType` and offset value.
    struct Data: Equatable {
        let type: ViewType
        let offset: CGFloat
    }

    // MARK: PreferenceKey

    // - SeeAlso: PreferenceKey.Value
    typealias Value = [Data]

    // - SeeAlso: PreferenceKey.defaultValue
    static var defaultValue: Value = []

    // - SeeAlso: PreferenceKey.reduce(value:, nextValue:)
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }

    // MARK: Lifecycle

    private static var threshold: CGFloat = Constants.pullThreshold

    /// Handles changes in scrolling view offset and updates refresh binding if threshold was exceeded.
    static func handleOffsetChange(
        values: [ScrollOffsetPreferenceKey.Data],
        isRefreshingBinding: Binding<Bool>
    ) {
        DispatchQueue.main.async {
            // Don't do anything if already refreshing.
            guard !isRefreshingBinding.wrappedValue else { return }

            // Unwrap offset values.
            let scrolledY = values.last { $0.type == .scrolling }?.offset ?? 0
            let fixedY = values.first { $0.type == .static }?.offset ?? 0

            // Calculate scroll offset.
            let scrollOffset = scrolledY - fixedY

            // We need to add first (stationary) offset to the threshold.
            if threshold == Constants.pullThreshold { threshold += scrollOffset }

            // Start refresh if offset exceeds threshold.
            if scrollOffset > threshold {
                isRefreshingBinding.wrappedValue = true
            }
        }
    }
}

// MARK: Extensions

extension View {

    private func view(ofType type: ScrollOffsetPreferenceKey.ViewType) -> some View {
        GeometryReader {
            Color.clear
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: [ScrollOffsetPreferenceKey.Data(type: type, offset: $0.frame(in: .global).minY)]
                )
        }
        .frame(height: 0)
    }

    /// Setups `View` to handle pull to refresh logic.
    ///
    /// - Parameters:
    ///   - isRefreshingBinding: `Binding` to property indicating if the screen is refreshing the data.
    func setupPullToRefresh(isRefreshingBinding: Binding<Bool>) -> some View {
        onPreferenceChange(ScrollOffsetPreferenceKey.self) {
            ScrollOffsetPreferenceKey.handleOffsetChange(
                values: $0,
                isRefreshingBinding: isRefreshingBinding)
        }
        .overlay(
            ProgressView(),
            binding: isRefreshingBinding,
            alignment: .top)
        .background(view(ofType: .static))
    }

    /// Setups `View` to act as pullable view for pull to refresh.
    ///
    /// - Parameters:
    ///   - isFirstItem: value indicating if the `View` is first item on the list and should be wrapped for pull to refresh.
    func wrapForPullToRefresh(isFirstItem: Bool) -> some View {
        ZStack {
            if isFirstItem { view(ofType: .scrolling) }
            self
        }
        .wrapForListUsage()
    }
}