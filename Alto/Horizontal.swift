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

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: Horizontal, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Horizontal>, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: Horizontal, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Horizontal, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Horizontal>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}
