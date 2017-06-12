import Foundation

public enum Edges {
    case edges
}

extension Edges: QuadrupleOffset, QuadrupleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .edges: return (.left, .top, .right, .bottom)
        }
    }
}

public extension UIView {

    @discardableResult
    public func set(_ attr1: Edges, _ relation: Relation, _ view: UIView, _ attr2: Edges, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func set(_ attr1: Edges, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Edges>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func set(_ attr1: Edges, _ relation: Relation, _ view: UIView, _ attr2: Edges, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    public func set(_ attr1: Edges, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Edges>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }
}
