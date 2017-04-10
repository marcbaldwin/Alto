import UIKit

public protocol LayoutKey {

    var layoutKey: String { get }
}

extension String: LayoutKey {

    public var layoutKey: String { return self }
}

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
        if let subLayout = sublayouts[key.layoutKey] {
            return subLayout
        } else {
            let sublayout = Layout()
            sublayouts[key.layoutKey] = sublayout
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
        let layoutKeys = keys.map { $0.layoutKey }
        return sublayouts.filter { layoutKeys.contains($0.key) } .map { $0.value }
    }
}
