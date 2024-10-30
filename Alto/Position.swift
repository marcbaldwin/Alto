import UIKit

public enum Position {
    case center, topLeft, topRight, bottomLeft, bottomRight,
    leftCenter, rightCenter, topCenter, bottomCenter
}

extension Position: DoubleOffset, DoubleAttribute {

    var nsAttributes: (NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute) {
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

    @discardableResult
    func set(_ attr1: Position, _ relation: Relation, _ view: UIView, _ attr2: Position, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }

    @discardableResult
    func set(_ attr1: Position, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Position>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, attr1, relation, view, attr2, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    func set(_ attr1: Position, _ relation: Relation, _ view: UIView, _ attr2: Position, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }

    @discardableResult
    func set(_ attr1: Position, _ relation: Relation, _ view: UIView, _ attr2: MultiplierOffset<Position>, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attr1, relation, view, attr2, priority: priority, isActive: isActive) }
    }
}
