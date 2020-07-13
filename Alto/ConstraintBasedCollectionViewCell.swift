import UIKit

open class ConstraintBasedCollectionViewCell: UICollectionViewCell {

    public var boundObjectId: String?
    public var hasInitConstraints = false

    open var initialSubviews: [UIView] {
        return []
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    override open func updateConstraints() {
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
        super.updateConstraints()
    }

    open func initView() {
        initialSubviews.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        setNeedsUpdateConstraints()
    }

    open func initConstraints() { }
}

open class ConstraintBasedCollectionReusableView: UICollectionReusableView {

    open var hasInitConstraints = false

    open var initialSubviews: [UIView] {
        return []
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    override open func updateConstraints() {
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
        super.updateConstraints()
    }

    open func initView() {
        initialSubviews.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        setNeedsUpdateConstraints()
    }

    open func initConstraints() { }
}
