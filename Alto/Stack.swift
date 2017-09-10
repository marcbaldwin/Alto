import Foundation

public enum Stack {
    case vertically, verticallyToBaseline, horizontally, leadingToTrailing
}

extension Stack: DoubleAttribute {

    var nsAttributes: (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .horizontally: return (.left, .right)
        case .leadingToTrailing: return (.leading, .trailing)
        case .vertically: return (.top, .bottom)
        case .verticallyToBaseline: return (.top, .lastBaseline)
        }
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func stack(_ attribute: Stack, in view: UIView? = nil, margin: CGFloat = 0, containerMargin: CGFloat = 0, isActive: Bool = true) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let attributes = attribute.nsAttributes

        if let view = view {
            if let first = first {
                constraints.append(NSLayoutConstraint(first, attributes.0, .equal, view, attributes.0, 1, containerMargin, isActive: isActive))
            }
            if let last = last {
                constraints.append(NSLayoutConstraint(last, attributes.1, .equal, view, attributes.1, 1, -containerMargin, isActive: isActive))
            }
        }

        for (first, second) in zip(dropFirst(1), dropLast(1)) {
            constraints.append(NSLayoutConstraint(first, attributes.0, .equal, second, attributes.1, 1, margin, isActive: isActive))
        }
        return constraints
    }
}
