import UIKit
import XCTest

extension NSLayoutConstraint {

    static func assert(_ lhs: NSLayoutConstraint, equals rhs: NSLayoutConstraint) {
        XCTAssertEqual(lhs.firstAttribute, rhs.firstAttribute)
        XCTAssertEqual(lhs.secondAttribute, rhs.secondAttribute)
        XCTAssertEqual(lhs.constant, rhs.constant)
        XCTAssertEqual(lhs.multiplier, rhs.multiplier)
        XCTAssertEqual(lhs.priority, rhs.priority)
        XCTAssertEqual(lhs.isActive, rhs.isActive)
    }

    static func assert(_ lhs: [NSLayoutConstraint], equal rhs: [NSLayoutConstraint]) {
        zip(lhs, rhs).forEach { lhs, rhs in
            assert(lhs, equals: rhs)
        }
    }
}
