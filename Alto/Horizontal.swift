import Foundation

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

public extension UIView {

    @discardableResult
    public func set(_ attr1: Horizontal, _ relation: Relation, _ view: UIView, _ attr2: Horizontal, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Horizontal, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Horizontal>, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func set(_ attr1: Horizontal, _ relation: Relation, _ view: UIView, _ attr2: Horizontal, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Horizontal, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Horizontal>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }
}
