
# Alto
Create layouts that support every device and orientation.

## Under Development
Alto is still being developed. A stable version will be released very soon. Star or Watch to keep updated with the progress :)

## Aims
Alto was developed to be:

#### Readable

```Swift
// Align the center of titleLabel 40px from the top of the container
titleLabel.set(.centerY, .equalTo, containerView, .top + 40)

// Align the centers of titleLabel and subtitleLabel to the container
[titleLabel, subtitleLabel].set(.centerX, .equalTo, containerView, .centerX)
```

#### Compile Safe

This compiles but will cause a crash
```Swift
NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem:
containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
```
This does not compile :)
```Swift
titleLabel.set(.height, .equalTo, containerView, .centerX) <-- Error
```

#### Fast and Simple

1. Small API
- Convenience attributes to reduce code needed, see features
- **No operator overloads** which can increase compile time

#### Well Documented
View the examples and diagrams [coming soon]()

## Features

#### Extra Attributes

Such as: `.center`, `.size`, `.edges`, `.topLeft`

```Swift
titleLabel.set(.center, .equalTo, containerView, .center)
titleLabel.set(.topLeft, .equalTo, containerView, .bottomRight)
titleLabel.set(.edges, .equalTo, containerView, .edges - 5)
```

#### View Grouping

Apply the same constraints to many views

```Swift
[titleLabel, subtitleLabel].set(.center, .equalTo, containerView, .center)
```

#### Stack Layouts
Create [`UIStackView`](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIStackView_Class_Reference/#//apple_ref/occ/instp/UIStackView/) style layouts just using constraints

```Swift
views.stack(.vertically, margin: 20)
views.stack(.vertically, in: containerView, margin: 20)
```

#### Clear Priorities

```Swift
titleLabel.set(.width, .greaterThanOrEqualTo, containerView, .width, priority: .low)
```

#### Todo List

1. Size Classes
2. Layout Guide Support

## Resources
- [Examples and Diagrams]()
- [Apple's Auto Layout Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/)
- [Change Log]()
