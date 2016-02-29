
# Alto
Alto helps developers create layouts that support every device and orientation.

## Under Development
Alto is still being developed. A stable version will be released very soon. Star or Watch to keep updated with the progress :)

## Aims
Alto was developed to be:
- **Readable**

 ```Swift
//  The top left of myView should equal the top right of view
layout.make(the: .TopLeft, of(myView), .EqualTo, the: .TopRight, of(view))
```

- **Compile Safe**

 ```Swift
// This compiles but causes the app to crash
NSLayoutConstraint(item: myView, attribute: .Height, relatedBy: .Equal, toItem:
        view, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0)
```
 ```Swift
// This does not compile :)
layout.make(the: .Height, of(myView), .EqualTo, the: .LeadingMargin, of(view)) <-- Error
```

- **Simple**

 Alto has a small API with no operator overloads or extra properties on `UIView`
 ```Swift
layout.make(the: .Edges, of(myView), .EqualTo, the: .Edges, of(containerView))
```

- **Well Documented** View the examples and diagrams [here]()

## Features

- **Extra Attributes** Including `.Center`, `.Size`, `.Edges`, `.TopLeft`. See the full list [here]()

 ```Swift
layout.make(the: .Size, of(titleLabel), .EqualTo, the: .Size, of(containerView))
```

- **View Grouping** Apply the same constraints to many views

 ```Swift
layout.make(the: .Left, of(titleLabel, detailLabel), .EqualTo, the: .Left, of(containerView))
```

- **Clear Priorities**
 ```Swift
// Use make for required constraints
layout.make(the: .Top, of(titleLabel, detailLabel), .EqualTo, the: .Top, of(containerView))
```
 ```Swift
// Use tryTo for optional constraints
layout.tryTo.make(the: .Width, of(titleLabel), .EqualTo, the: .Width, of(containerView))
```
 ```Swift
// Use tryToWithPriority to prioritize constraints
layout.tryToWithPriority(.Low).make(the: .Width, of(titleLabel), .EqualTo, the: .Width, of(containerView))
```

- **Size Classes** Alto applies constraints for particular size classes for you

 ```Swift
// Constraint only applied when on compact width
layout.when(.CompactWidth).make(the: .Width, of(titleLabel), .EqualTo, the: .Width, of(containerView))
```
- **Layout Guide Support**

 ```Swift
layout.make(the: .Top, of(titleLabel), .EqualTo, the: .Bottom, of(layoutGuide))
```
- **Animation** Constraint switching and animation is simple

## Resources
- [Examples and Diagrams]()
- [Apple's Auto Layout Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/)
- [Change Log]()
