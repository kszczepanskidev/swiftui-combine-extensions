# SwiftUI

## [AlignedStacks](/SwiftUI/AlignedStacks/)

## [ScrollView](/SwiftUI/ScrollView/)

## KeyboardAdaptiveModifier
`ViewModifier` that adjusts view's bottom padding based on current keyboard height.

Simple usage example:
```swift
VStack {
    TextField("Input 1", text: $input1)
    TextField("Input 2", text: $input2)
}
.keyboardAdaptive()
```

## RoundedCorners
SwiftUI marks `.cornerRadius(_:, antialiased)` modifier as deprecated and recommends use of `clipShape(_:style:)` or `fill(style:)`.
This helper simplifies adding rounded corners by bringing back `.cornerRadius(_:, corners:)` modifier with ability to select which corners should be rounded.

Before:
```swift
    Button("CLICK", action: {})
     .backgroundColor(.red)
     .clipShape(RoundedCorners(radius: 16))
```

After:
```swift
    Button("CLICK", action: {})
     .backgroundColor(.red)
     .cornerRadius(16)
```

## Size reader
`ViewModifier` that allows reading the size of UI component.

Simple usage example:
```swift
@State var buttonSize = CGSize()

var body: some View {
     Button("CLICK", action: {})
         .sizeModifier(size: .init(get: { .zero }, set: { buttonSize = $0 }))
}

```

## `View` extensions

### hidden(\_:\)
Simplifies code for applying `.hidden()` modifier to views. Useful when it's required to hide one of views in a Stack with preserving the same layout.

Before:
```swift
HStack {
    Button("CLICK1", action: {})
    if shouldHideButton2 {
        Button("CLICK2", action: {})
            .hidden()
    } else {
        Button("CLICK2", action: {})
    }
    Button("CLICK3", action: {})
}
```

After:
```swift
HStack {
    Button("CLICK1", action: {})
    Button("CLICK2", action: {})
        .hidden(shouldHideButton2)
    Button("CLICK3", action: {})
}
```

### innerShadow(shape:, angle:, color:, radius:, blur:)
Simplifies adding inner shadow to a view using parameters from common designing tools like Figma or Zepplin.

Simple usage example:
```swift
Button("CLICK", action: {})
    .innerShadow(
        using: RoundedRectangle(cornerRadius: 8),
        angle: .degrees(145),
        color: .black,
        radius: 3,
        blur: 12
    )
```

### View frame

#### frame(side:, alignment:)
Simplifies sizing views into rectangle sized frame.

Before:
```swift
    Button("CLICK", action: {})
        .frame(width: 48, height: 48)
```

After:
```swift
    Button("CLICK", action: {})
        .frame(side: 48)
```

#### frame(size:, alignment:)
Simplifies sizing views with given `CGSize` value.

Before:
```swift
    let size = CGSize()
    Button("CLICK", action: {})
        .frame(width: size.width, height: size.height)
```

After:
```swift
    let size = CGSize()
    Button("CLICK", action: {})
        .frame(size: size)
```

### Padding

####  padding(horizontal:, vertical:)
Simplifies adding both horizontal and vertical paddings to a view.

Before:
```swift
   Text("Some Text")
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
```

After:
```swift
   Text("Some Text")
        .padding(horizontal: 24, vertical: 8)
```

####  padding(top:, bottom:)
Simplifies adding both top and bottom paddings to a view.

Before:
```swift
   Text("Some Text")
        .padding(.top, 8)
        .padding(.bottom, 24)
```

After:
```swift
   Text("Some Text")
        .padding(top: 8, bottom: 24)
```

### overlay(_, binding:, alignment:)
Simplifies adding overlay on a view with condition to hide it. Useful for example for adding badge counters that hide when value is `0`.

Simple usage example:
```swift
@State var updatesCount: Int = 0
Text("Updates")
    .overlay(
        SomeOverlayView(),
        binding: .init(get: { updatesCount > 0 }, set : { _ in }))
```

### wrapForTapGesture(action:)
Simple wrapper that adds `contentShape(Rectangle())` to view to ensure tap gesture will be recognized. This is required to add tap gestures to containers like `H/V/ZStack`. Useful when there's short Text component and tap gesture need to be recognized on full width of the screen.

Simple usage example:
```swift
List {
    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit...")
    HStack {
        Text("Short Clickable Text")
        Spacer()
    }
    .wrapForTapGesture(action: {})
}
```
