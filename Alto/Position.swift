import Foundation

public enum Position {
    case center, topLeft, topRight, bottomLeft, bottomRight,
    leftCenter, rightCenter, topCenter, bottomCenter
}

extension Position: DoubleOffset, DoubleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .center: return (.centerX, .centerY)
        case .topLeft: return (.left, .top)
        case .topRight: return (.right, .top)
        case .bottomLeft: return (.left, .bottom)
        case .bottomRight: return (.right, .bottom)
        case .leftCenter: return (.left, .centerY)
        case .rightCenter: return (.right, .centerY)
        case .topCenter: return (.centerX, .top)
        case .bottomCenter: return (.centerX, .bottom)
        }
    }
}

public extension UIView {

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: Position, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Position>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attribute, relation, view, anotherAttribute, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: Position, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }

    @discardableResult public func set(_ attribute: Position, _ relation: Relation, _ view: UIView, _ anotherAttribute: MultiplierOffset<Position>, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, view, anotherAttribute, isActive: isActive) }
    }
}
