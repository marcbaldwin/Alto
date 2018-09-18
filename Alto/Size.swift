import Foundation

public enum Size {
    case size
}

extension Size: DoubleOffset, DoubleAttribute {

    var nsAttributes: (NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute) {
        switch self {
        case .size: return (.width, .height)
        }
    }
}

extension UIView {

    @discardableResult
    public func set(_ attr1: Size, _ relation: Relation, _ view: UIView, _ attr2: Size, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Size, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Size>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }
}


public extension Array where Element: UIView {

    @discardableResult
    public func set(_ attr1: Size, _ relation: Relation, _ view: UIView, _ attr2: Size, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Size, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Size>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(same attr: Size, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return dropLast(1).flatMap { $0.set(attr, .equalTo, last!, attr, priority: priority, isActive: isActive) }
    }
}
