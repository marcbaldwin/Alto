import XCTest
@testable import Alto

class AlignmentEdgesTests: XCTestCase {

    func test_verticalEdges() {
        let view = UIView()
        let superView = UIView()

        let constraints = view.align(.verticalEdges, to: superView, isActive: false)

        let expectedConstraints = [
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1, constant: 0)
        ]

        NSLayoutConstraint.assert(constraints, equal: expectedConstraints)
    }
}
