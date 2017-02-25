import Foundation

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

extension UIView {

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: Size, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, priority: priority, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Size>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}


public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: Size, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Size, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Size>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(same attribute: Size, isActive: Bool = true) -> [NSLayoutConstraint] {
        return dropLast(1).flatMap { $0.set(attribute, .equalTo, last!, attribute, isActive: isActive) }
    }
}
