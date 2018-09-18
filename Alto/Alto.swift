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

    var nsAttribute: NSLayoutConstraint.Attribute { get }
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
    var nsAttributes: (NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute) { get }
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
    var nsAttributes: (NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute) { get }
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

    var nsRelation: NSLayoutConstraint.Relation {
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

    var value: UILayoutPriority {
        switch self {
        case .low: return .defaultLow
        case .high: return .defaultHigh
        }
    }
}

//

extension NSLayoutConstraint {

    // MARK: Single Attribute

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attr1: T, _ relation: Alto.Relation, _ constant: CGFloat, priority: Priority?, isActive: Bool) {
        self.init(view, attr1.nsAttribute, relation.nsRelation, nil, .notAnAttribute, 1, constant, priority: priority?.value, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attr1: T, _ relation: Alto.Relation, _ view2: AnyObject, _ attr2: T, priority: Priority?, isActive: Bool) {
        self.init(view, attr1.nsAttribute, relation.nsRelation, view2, attr2.nsAttribute, 1, 0, priority: priority?.value, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: AnyObject, _ attr1: T, _ relation: Alto.Relation, _ view2: AnyObject, _ attr2: MultiplierOffset<T>, priority: Priority?, isActive: Bool) {
        self.init(view, attr1.nsAttribute, relation.nsRelation, view2, attr2.attribute.nsAttribute, attr2.multiplier, attr2.offset, priority: priority?.value, isActive: isActive)
    }

    // MARK: DoubleAttribute

    static func create<T: DoubleAttribute>(_ view1: UIView, _ attr1: T, _ relation: Alto.Relation, _ view2: UIView, _ attr2: T, _ m: CGFloat = 1, _ c: CGFloat = 0, priority: Priority?, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view1, attr1.nsAttributes.0, relation.nsRelation, view2, attr2.nsAttributes.0, m, c, priority: priority?.value, isActive: isActive),
            NSLayoutConstraint(view1, attr1.nsAttributes.1, relation.nsRelation, view2, attr2.nsAttributes.1, m, c, priority: priority?.value, isActive: isActive)
        ]
    }

    static func create<T: DoubleAttribute>(_ view1: UIView, _ attr1: T, _ relation: Alto.Relation, _ view2: UIView, _ attr2: MultiplierOffset<T>, priority: Priority?, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view1, attr1, relation, view2, attr2.attribute, attr2.multiplier, attr2.offset, priority: priority, isActive: isActive)
    }

    // MARK: QuadrupleAttribute

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attr1: T, _ relation: Alto.Relation, _ view2: UIView, _ attr2: T, _ m: CGFloat = 1, _ c: CGFloat = 0, priority: Priority?, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view, attr1.nsAttributes.0, relation.nsRelation, view2, attr2.nsAttributes.0, m, -c, priority: priority?.value, isActive: isActive),
            NSLayoutConstraint(view, attr1.nsAttributes.1, relation.nsRelation, view2, attr2.nsAttributes.1, m, -c, priority: priority?.value, isActive: isActive),
            NSLayoutConstraint(view, attr1.nsAttributes.2, relation.nsRelation, view2, attr2.nsAttributes.2, m, c, priority: priority?.value, isActive: isActive),
            NSLayoutConstraint(view, attr1.nsAttributes.3, relation.nsRelation, view2, attr2.nsAttributes.3, m, c, priority: priority?.value, isActive: isActive)
        ]
    }

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attr1: T, _ relation: Alto.Relation, _ view2: UIView, _ attr2: MultiplierOffset<T>, priority: Priority?, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view, attr1, relation, view2, attr2.attribute, attr2.multiplier, attr2.offset, priority: priority, isActive: isActive)
    }
}
