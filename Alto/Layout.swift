import UIKit

public typealias LayoutKey = String

public class Layout {

    private var constraints = [NSLayoutConstraint]()
    private var sublayouts = [String : Layout]()
    private var allConstraints: [NSLayoutConstraint] {
        return constraints + sublayouts.values.flatMap({ $0.allConstraints })
    }

    public init() {
        
    }

    public static func +=(layout: Layout, constraints: [NSLayoutConstraint]) {
        layout.constraints += constraints
    }

    public static func +=(layout: Layout, constraint: NSLayoutConstraint) {
        layout.constraints += [constraint]
    }

    public subscript(key: LayoutKey) -> Layout {
        if let subLayout = sublayouts[key] {
            return subLayout
        } else {
            let sublayout = Layout()
            sublayouts[key] = sublayout
            return sublayout
        }
    }

    public func activate() {
        allConstraints.forEach { $0.isActive = true }
    }

    public func deactivate() {
        allConstraints.forEach { $0.isActive = false }
    }

    public func activate(keys: LayoutKey...) {
        sublayouts(keys).forEach { $0.activate() }
    }

    public func deactivate(keys: LayoutKey...) {
        sublayouts(keys).forEach { $0.deactivate() }
    }

    private func sublayouts(_ keys: [LayoutKey]) -> [Layout] {
        return sublayouts.filter { keys.contains($0.key) } .map { $0.value }
    }
}
