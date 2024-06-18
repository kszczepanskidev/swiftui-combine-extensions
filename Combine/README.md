# Combine

## PublishSubject
Wrapper for `Combine.PassthroughSubject` that forces failure type to `Never`, so you don't need to write it every time you declare publisher type.

Before:
```swift
let exampleSubject = PassthroughSubject<Bool, Never>()
```

After:
```swift
let exampleSubject = PublishSubject<Bool>()
```

## ValueSubject
Wrapper for `Combine.CurrentValueSubject` that forces failure type to `Never`, so you don't need to write it every time you declare publisher type.

Before:
```swift
let exampleSubject = CurrentValueSubject<Bool, Never>(false)
```

After:
```swift
let exampleSubject = ValueSubject<Bool>(false)
```

## Publisher extensions

### asVoid()
Simplifies dropping publisher values with mapping them to `Void()`. Reduces usage of empty arguments and braces in code for better readability.


Before:
```swift
exampleSubject
    .map { _ in Void() }
    .sink {}
```

After:
```swift
exampleSubject
    .asVoid()
    .sink {}
```

### filterNil()
Simplifies dropping `nil` values in publisher with optional output type. Reduces usage of short braces in code for better readability.


Before:
```swift
exampleOptionalSubject
    .compactMap { $0.value }
    .sink {}
```

After:
```swift
exampleOptionalSubject
    .filterNil()
    .sink {}
```

### firstNotNil()
Simplifies subscribing to first not nil value in publisher with optional output type. Reduces usage of short braces in code for better readability.


Before:
```swift
exampleOptionalSubject
    .first { $0.value != nil }
    .sink {}
```

After:
```swift
exampleOptionalSubject
    .firstNotNil()
    .sink {}
```
