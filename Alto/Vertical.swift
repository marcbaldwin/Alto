import Foundation

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

public extension UIView {

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: Vertical, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Vertical>, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ anotherAttribute: Vertical, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UILayoutSupport, _ anotherAttribute: MultiplierOffset<Vertical>, isActive: Bool = true) -> NSLayoutConstraint {
        return NSLayoutConstraint(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: Vertical, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Vertical, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Vertical>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}
