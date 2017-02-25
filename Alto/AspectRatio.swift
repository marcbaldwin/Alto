import Foundation

public enum ConstantAttribute {
    case aspectRatio
}

public extension UIView {

    @discardableResult public func set(_ attribute: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return set(.width, .equalTo, self, .height * constant , priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult public func set(_ attribute: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.set(attribute, relation, constant, isActive: isActive) }
    }
}
