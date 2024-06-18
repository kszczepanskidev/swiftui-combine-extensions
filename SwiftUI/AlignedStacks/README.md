# AlignedH/VStack
Simplifies adding `Spacers` for same-axis alignment in `H-/VStacks`.

## AlignedHStack
Adds additional `horizontalAlignment` parameter to `HStack` container. Also provides simple `View` modifier for single object wrapping.

### Normal `AlignedHStack` usage:
Before:
```swift
HStack(spacing: 4) {
    Spacer()
    Text("Some text")
        .foregroundColor(.red)
    Image(systemName: "chevron")
}
```
Before:
```swift
AlignedHStack(horizontalAlignment: .trailing, spacing: 4) {
    Text("Some text")
        .foregroundColor(.red)
    Image(systemName: "chevron")
}
```

### `horizontalAlignment` modifier usage:
Before:
```swift
HStack() {
    Spacer()
    Text("Some text")
        .foregroundColor(.red)
    Spacer()
}
```
Before:
```swift
Text("Some text")
    .foregroundColor(.red)
    .horizontalAlignment(.center)
```


## AlignedVStack
Adds additional `verticalAlignment` parameter to `VStack` container. Also provides simple `View` modifier for single object wrapping.

### Normal `AlignedVStack` usage:
Before:
```swift
VStack(spacing: 4) {
    Spacer()
    Text("Some text 1")
        .foregroundColor(.red)
    Text("Some text 2")
        .foregroundColor(.yellow)
    Spacer()
}
```
Before:
```swift
AlignedVStack(verticalAlignment: .center, spacing: 4) {
    Text("Some text 1")
        .foregroundColor(.red)
    Text("Some text 2")
        .foregroundColor(.yellow)
}
```

### `verticalAlignment` modifier usage:
Before:
```swift
VStack() {
    Spacer()
    Text("Some text")
        .foregroundColor(.red)
}
```
Before:
```swift
Text("Some text")
    .foregroundColor(.red)
    .verticalAlignment(.bottom)
```
