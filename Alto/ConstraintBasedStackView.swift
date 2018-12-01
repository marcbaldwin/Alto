import UIKit

@available(iOS 9.0, *)
open class ConstraintBasedStackView: UIStackView {

    open var hasInitConstraints = false

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required public init(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    open func initView() {

    }

    override open func updateConstraints() {
        super.updateConstraints()
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
    }

    open func initConstraints() {

    }
}
