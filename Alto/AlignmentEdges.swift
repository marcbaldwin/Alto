import Foundation

public enum AlignmentEdges {
    case horizontalEdges, verticalEdges
}

extension AlignmentEdges: DoubleAttribute {

    var nsAttributes: (NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute) {
        switch self {
        case .horizontalEdges:
            return (.top, .bottom)
        case .verticalEdges:
            return (.left, .right)
        }
    }
}

public extension UIView {

    @discardableResult
    public func align(_ edges: AlignmentEdges, to view: UIView, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.create(self, edges, .equalTo, view, edges, priority: priority, isActive: isActive)
    }
}

public extension Array where Element: UIView {

    @discardableResult
    public func align(_ edges: AlignmentEdges, to view: UIView, priority: Priority? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        return flatMap { $0.align(edges, to: view, priority: priority, isActive: isActive) }
    }
}
