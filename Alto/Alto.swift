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

// MARK: Attributes

public enum Horizontal {
    case centerX, left, right, leading, trailing
}

extension Horizontal: SingleOffset, SingleAttribute {

    var nsAttribute: NSLayoutAttribute {
        switch self {
        case .centerX: return .centerX
        case .left: return .left
        case .right: return .right
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }
}

public enum Vertical {
    case centerY, top, bottom
}

extension Vertical: SingleOffset, SingleAttribute {

    var nsAttribute: NSLayoutAttribute {
        switch self {
        case .centerY: return .centerY
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

public enum Position {
    case center, topLeft, topRight, bottomLeft, bottomRight,
    leftCenter, rightCenter, topCenter, bottomCenter
}

extension Position: DoubleOffset, DoubleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .center: return (.centerX, .centerY)
        case .topLeft: return (.left, .top)
        case .topRight: return (.right, .top)
        case .bottomLeft: return (.left, .bottom)
        case .bottomRight: return (.right, .bottom)
        case .leftCenter: return (.left, .centerY)
        case .rightCenter: return (.right, .centerY)
        case .topCenter: return (.centerX, .top)
        case .bottomCenter: return (.centerX, .bottom)
        }
    }
}

public enum Dimension {
    case width, height
}

extension Dimension: SingleOffset, SingleAttribute {

    var nsAttribute: NSLayoutAttribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }
}

public enum Size {
    case size
}

extension Size: DoubleOffset, DoubleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .size: return (.width, .height)
        }
    }
}

public enum Edges {
    case edges
}

extension Edges: QuadrupleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .edges: return (.left, .top, .right, .bottom)
        }
    }
}

public enum ConstantAttribute {
    case aspectRatio
}

// MARK: Single Attribute

protocol SingleAttribute {

    var nsAttribute: NSLayoutAttribute { get }
}

public protocol SingleOffset {
    static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self>
    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
    static func -(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension SingleOffset {

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

// MARK: Double Attribute

protocol DoubleAttribute {
    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) { get }
}

public protocol DoubleOffset {

    static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self>
    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension DoubleOffset {

    public static func *(attribute: Self, multiplier: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, multiplier: multiplier)
    }

    public static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: offset)
    }
}

// MARK: Quadruple Attribute

protocol QuadrupleAttribute {
    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute) { get }
}

public protocol QuadrupleOffset {

    static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self>
}

extension QuadrupleOffset {

    public static func +(attribute: Self, offset: CGFloat) -> MultiplierOffset<Self> {
        return MultiplierOffset(attribute: attribute, offset: offset)
    }
}

// MARK: Stack

public enum Stack {
    case vertically, horizontally, leadingToTrailing
}

extension Stack: DoubleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .horizontally: return (.left, .right)
        case .leadingToTrailing: return (.leading, .trailing)
        case .vertically: return (.top, .bottom)
        }
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

//

extension NSLayoutConstraint {

    // MARK: Single Attribute

    convenience init<T: SingleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ constant: CGFloat, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, nil, .notAnAttribute, 1, constant, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, anotherView, anotherAttribute.nsAttribute, 1, 0, isActive: isActive)
    }

    convenience init<T: SingleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, isActive: Bool) {
        self.init(view, attribute.nsAttribute, relation.nsRelation, anotherView, anotherAttribute.attribute.nsAttribute, anotherAttribute.multiplier, anotherAttribute.offset, isActive: isActive)
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ constant: CGFloat, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, constant, isActive: isActive) }
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, anotherView, anotherAttribute, isActive: isActive) }
    }

    static func create<T: SingleAttribute>(_ views: [UIView], _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, isActive: Bool) -> [NSLayoutConstraint] {
        return views.flatMap { NSLayoutConstraint($0, attribute, relation, anotherView, anotherAttribute, isActive: isActive) }
    }

    // MARK: Double Attribute

    static func create<T: DoubleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, _ m: CGFloat = 1, _ c: CGFloat = 0, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view, attribute.nsAttributes.0, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.0, m, c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.1, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.1, m, c, isActive: isActive)
        ]
    }

    static func create<T: DoubleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view, attribute, relation, anotherView, anotherAttribute.attribute, anotherAttribute.multiplier, anotherAttribute.offset, isActive: isActive)
    }

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: T, _ m: CGFloat = 1, _ c: CGFloat = 0, isActive: Bool) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(view, attribute.nsAttributes.0, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.0, m, c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.1, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.1, m, c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.2, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.2, m, c, isActive: isActive),
            NSLayoutConstraint(view, attribute.nsAttributes.3, relation.nsRelation, anotherView, anotherAttribute.nsAttributes.3, m, c, isActive: isActive)
        ]
    }

    static func create<T: QuadrupleAttribute>(_ view: UIView, _ attribute: T, _ relation: Relation, _ anotherView: UIView, _ anotherAttribute: MultiplierOffset<T>, isActive: Bool) -> [NSLayoutConstraint] {
        return create(view, attribute, relation, anotherView, anotherAttribute.attribute, anotherAttribute.multiplier, anotherAttribute.offset, isActive: isActive)
    }
}

public extension UIView {

    // MARK: Horizontal

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: Horizontal, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Horizontal>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    // MARK: Vertical

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: Vertical, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Vertical>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    // MARK: Position

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: Position, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Position>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    // MARK: Edges

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: Edges, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Edges>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    // MARK: Dimension

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: Dimension, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Dimension>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)]
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(self, attribute, relation, constant, isActive: isActive)]
    }

    // MARK: Size

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: Size, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Size>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    // MARK: Other attributes

    @discardableResult public func set(_ attribute: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> [NSLayoutConstraint] {
        return set(.width, .equalTo, self, .height, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    // MARK: Horizontal

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: Horizontal, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Horizontal>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    // MARK: Vertical

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: Vertical, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Vertical>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    // MARK: Position

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: Position, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Position>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    // MARK: Edges

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: Edges, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Edges>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    // MARK: Dimension

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: Dimension, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Dimension>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, constant, isActive: isActive)
    }

    @discardableResult public func set(same attribute: Dimension, isActive: Bool = true) -> [NSLayoutConstraint] {
        return dropLast(1).flatMap { $0.set(attribute, .equalTo, last!, attribute, isActive: isActive) }
    }

    // MARK: Size

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: Size, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Size>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(same attribute: Size, isActive: Bool = true) -> [NSLayoutConstraint] {
        return dropLast(1).flatMap { $0.set(attribute, .equalTo, last!, attribute, isActive: isActive) }
    }

    // MARK: Stack

    @discardableResult public func stack(_ attribute: Stack, margin: CGFloat = 0, isActive: Bool = true) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let attributes = attribute.nsAttributes
        for (first, second) in zip(dropFirst(1), dropLast(1)) {
            constraints.append(NSLayoutConstraint(first, attributes.0, .equal, second, attributes.1, 1, margin, isActive: isActive))
        }
        return constraints
    }

    // MARK: Other attributes

    @discardableResult public func set(_ attribute: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, constant, isActive: isActive) }
    }
}

func testy() {
    let parent = UIView()
    let view = UIView()
    let views = [UIView]()

    //    let layout = SuperLayout()

    view.set(.aspectRatio, .equalTo, 5)
    //    views.set(.aspectRatio, .equalTo, 5)
    view.set(.left, .equalTo, parent, .left)
    view.set(.left, .equalTo, parent, .left + 10)
    view.set(.left, .equalTo, parent, .left - 10)
    view.set(.top, .equalTo, parent, .top)
    view.set(.width, .equalTo, parent, .width * 0.5)
    //    view.set(.size, .equalTo, parent, .size * 0.5)
    view.set(.width, .equalTo, 20)
    views.set(same: .size)
}
