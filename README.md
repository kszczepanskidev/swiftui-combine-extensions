# Bits and pieces for SwiftUI and Combine
This repository is a collection of code snippets I found useful while working on project utilizing SwiftUI and Combine (supporting iOS 14+). Most of these are simple extensions or helper functions that make writing code easier and cleaner. The idea behind it is to provide really small improvements that will be used often.
An important thing to note is that while they make writing code smoother, they also increase amount of required knowledge. Each new developer in the project will need to learn about all of those custom pieces of code so they can follow project coding style.

## [Combine](/Combine/)
- [Publisher extensions](/Combine#publisher-extensions).
- [`Passthrough-/CurrentValueSubject` wrappers](/Combine#publishsubject).

## [SwiftUI](/SwiftUI)
- [`H-/VStack` with spacer alignment](/SwiftUI/AlignedStacks#alignedhvstack).
- [`ScrollView` extensions and offset reader](/SwiftUI/ScrollView#scrollview).
- [Keyboard padding `Publisher`](/SwiftUI#keyboardadaptivemodifier).
- [Rounded corners helper](/SwiftUI#roundedcorners).
- [`View` size reader](/SwiftUI#size-reader).
- [`View` extensions](/SwiftUI#view-extensions).
  - [Conditional view hiding](/SwiftUI#hidden_)
  - [Inner shadow with custom params](/SwiftUI#innershadowshape-angle-color-radius-blur)
  - [View frames](/SwiftUI#view-frame)
  - [View paddings](/SwiftUI#padding)
  - [Conditional overlay](/SwiftUI#overlay_-binding-alignment)
  - [Container tap gestures](/SwiftUI#wrapfortapgestureaction)
