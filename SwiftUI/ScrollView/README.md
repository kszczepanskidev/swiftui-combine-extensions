# ScrollView

## Extensions

### .fluidScroll(to:, anchor:)
Simplifies writing code to animate scrolling to given element within the `ScrollView` content.

Before:
```swift
func scrollToTop() {
    withAnimation {
        scrollTo(0, anchor: .top)
    }
}
```

After:
```swift
func scrollToTop() {
    fluidScroll(to: 0, anchor: .top)
}
```

## Offset Reader
`Preference Key` used for calculating scroll offset in `ScrollView` or `List` component. Requires adding two invisible views into content hierarchy.
This can be used to implement hiding parts of the UI when the content is scrolled or to add "Pull to refresh" on iOS 14 (`refreshable()` modifier is available in iOS 15+).

Simple usage example:
```swift
@State var isRefreshing: Bool = false
List {
    ForEach(objects, id: \.self) { object in
        CustomView(for: object)
            .wrapForPullToRefresh(isFirstItem: object == objects.first)
    }
}
.setupPullToRefresh(isRefreshingBinding: $isRefreshing)
```
