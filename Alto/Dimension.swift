import Foundation

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

public extension UIView {

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: Dimension, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, priority: priority, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Dimension>, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, priority: priority, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Dimension, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, constant, isActive: isActive)
    }
}

public extension Array where Element: UIView {

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
}
