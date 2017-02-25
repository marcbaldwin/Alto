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

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: Edges, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Edges>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: Edges, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Edges, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Edges>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }
}
