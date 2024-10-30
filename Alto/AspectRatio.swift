import UIKit

public enum ConstantAttribute {
    case aspectRatio
}

public extension UIView {

    @discardableResult
    func set(_ aspectRatio: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        return set(.width, .equalTo, self, .height * constant , priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    func set(_ aspectRatio: ConstantAttribute, _ relation: Relation, _ constant: CGFloat, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return map { $0.set(aspectRatio, relation, constant, priority: priority, isActive: isActive) }
    }
}
