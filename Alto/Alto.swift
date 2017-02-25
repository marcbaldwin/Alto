import UIKit

public struct MultiplierOffset<T> {

    let attribute: T
    let offset: CGFloat
    let multiplier: CGFloat

    init(attribute: T, offset: CGFloat = 0, multiplier: CGFloat = 1) {
        self.attribute = attribute
        self.offset = offset
        self.multiplier = multiplier
    }

    public static func +(attribute: MultiplierOffset, offset: CGFloat) -> MultiplierOffset<T> {
        return MultiplierOffset(attribute: attribute.attribute, offset: offset, multiplier: attribute.multiplier)
    }

    public static func -(attribute: MultiplierOffset, offset: CGFloat) -> MultiplierOffset<T> {
        return MultiplierOffset(attribute: attribute.attribute, offset: -offset, multiplier: attribute.multiplier)
    }
}

// MARK: Single Attribute

protocol SingleAttribute {

    var nsAttribute: NSLayoutAttribute { get }
}

public protocol SingleOffset {
    static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self>
    static func /(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self>
    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
    static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension SingleOffset {

    public static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, multiplier: multiplier)
    }

    public static func /(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, multiplier: 1/multiplier)
    }

    public static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: offset)
    }

    public static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: -offset)
    }
}

// MARK: Double Attribute

protocol DoubleAttribute {
    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) { get }
}

public protocol DoubleOffset {

    static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self>
    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
    static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension DoubleOffset {

    public static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, multiplier: multiplier)
    }

    public static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: offset)
    }

    public static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: -offset)
    }
}

// MARK: Quadruple Attribute

protocol QuadrupleAttribute {
    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute) { get }
}

public protocol QuadrupleOffset {

    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
    static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension QuadrupleOffset {

    public static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: offset)
    }

    public static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: -offset)
    }
}

// MARK: Relation

public enum Relation {
    case equalTo
    case lessThanOrEqualTo
    case greaterThanOrEqualTo

    var nsRelation: NSLayoutRelation {
        switch self {
        case .equalTo: return .equal
        case .lessThanOrEqualTo: return .lessThanOrEqual
        case .greaterThanOrEqualTo: return .greaterThanOrEqual
        }
    }
}

// MARK: Priority

public enum Priority {
    case low, high

    var value: Float {
        switch self {
        case .low: return UILayoutPriorityDefaultLow
        case .high: return UILayoutPriorityDefaultHigh
        }
    }
}

//

extension NSLayoutConstraint {

    // MARK: Single Attribute

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attribute: T, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, nil, .notAnAttribute, 1, constant, priority: priority?.value, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attribute: T, _ relation: Relation, _ anotherView: AnyObject, _ anotherAttribute: T, priority: Priority? = nil, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, anotherView, anotherAttribute.nsAttribute, 1, 0, priority: priority?.value, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attribute: T, _ relation: Relation, _ anotherView: AnyObject, _ anotherAttribute: MultiplierOffset<T>, priority: Priority? = nil, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, anotherView, anotherAttribute.attribute.nsAttribute, anotherAttribute.multiplier, anotherAttribute.offset, priority: priority?.value, isActive: isActive)
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, constant, priority: priority, isActive: isActive) }
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ view: UIView, _ anotherAttribute: T, priority: Priority? = nil, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, view, anotherAttribute, priority: priority, isActive: isActive) }
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<T>, priority: Priority? = nil, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, view, anotherAttribute, priority: priority, isActive: isActive) }
    }

    // MARK: DoubleAttribute

    static func create<T: DoubleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, _ m: CGFloat = 1, _ c: CGFloat = 0, priority: Priority? = nil, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view, attribute.nsAttributes.0, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.0, m, c, priority: priority?.value, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.1, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.1, m, c, priority: priority?.value, isActive: isActive)
        ]
    }

    static func create<T: DoubleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, priority: Priority? = nil, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view, attribute, relation, anotherView, anotherAttribute.attribute, anotherAttribute.multiplier, anotherAttribute.offset, isActive: isActive)
    }

    // MARK: QuadrupleAttribute

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, _ m: CGFloat = 1, _ c: CGFloat = 0, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view, attribute.nsAttributes.0, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.0, m, -c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.1, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.1, m, -c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.2, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.2, m, c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.3, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.3, m, c, isActive: isActive)
        ]
    }

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view, attribute, relation, anotherView, anotherAttribute.attribute, anotherAttribute.multiplier, anotherAttribute.offset, isActive: isActive)
    }
}
