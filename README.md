# Set

[![Build status](https://api.travis-ci.org/robrix/Set.svg)](https://travis-ci.org/robrix/Set)

This is a Swift microframework which implements a Dictionary-backed Set.

## Use

```swift
// Union
Set(1, 2, 3) + Set(3, 4, 5) // == Set(1, 2, 3, 4, 5)

// Difference
Set(1, 2, 3) - Set(2, 3) // == Set(1)

// Intersection
Set(1, 2, 3) & Set(3, 4, 5) // == Set(3)
```

See [`Set.swift`][Set.swift] for more details.

## Integration

1. Add this repo as a submodule in e.g. `External/Set`:
  
        git submodule add https://github.com/robrix/Set.git External/Set
2. Drag `Set.xcodeproj` into your `.xcworkspace`/`.xcodeproj`.
3. Add `Set.framework` to your target’s `Link Binary With Libraries` build phase.
4. You may also want to add a `Copy Files` phase which copies `Set.framework` (and any other framework dependencies you need) into your bundle’s `Frameworks` directory. If your target is a framework, you may instead want the client app to include `Set.framework`.

## Thanks

- [Greg Titus wrote a Set in Swift which inspired this](https://twitter.com/gregtitus/status/476420154230726656).

[Set.swift]: https://github.com/robrix/Set/blob/master/Set/Set.swift
