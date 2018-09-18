import Foundation

public enum Dimension {
    case width, height
}

extension Dimension: SingleOffset, SingleAttribute {

    var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }
}

public extension UIView {

    @discardableResult
    public func set(_ attr1: Dimension, _ relation: Relation, _ view: UIView, _ attr2: Dimension, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Dimension, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Dimension>, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr: Dimension, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr, relation, constant, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func set(_ attr1: Dimension, _ relation: Relation, _ view: UIView, _ attr2: Dimension, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Dimension, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Dimension>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr: Dimension, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr, relation, constant, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(same attr: Dimension, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return dropLast(1).map { $0.set(attr, .equalTo, last!, attr, priority: priority, isActive: isActive) }
    }
}
