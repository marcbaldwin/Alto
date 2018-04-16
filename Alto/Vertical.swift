import Foundation

public enum Vertical {
    case centerY, top, bottom, lastBaseline
}

extension Vertical: SingleOffset, SingleAttribute {

    var nsAttribute: NSLayoutAttribute {
        switch self {
        case .centerY: return .centerY
        case .top: return .top
        case .bottom: return .bottom
        case .lastBaseline: return .lastBaseline
        }
    }
}

public extension UIView {

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UIView, _ attr2: Vertical, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Vertical>, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ attr2: Vertical, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ attr2: MultiplierOffset<Vertical>, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UIView, _ attr2: Vertical, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Vertical>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ attr2: Vertical, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ attr2: MultiplierOffset<Vertical>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }
}
