import UIKit

open class ConstraintBasedTableViewCell: UITableViewCell {

    open var boundObjectId: String?
    open var hasInitConstraints = false

    open var initialSubviews: [UIView] {
        return []
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        setNeedsUpdateConstraints()
    }

    open func initConstraints() { }
}

open class ViewHolderTableViewCell: ConstraintBasedTableViewCell {

    open func subview() -> UIView {
        fatalError("subview is abstract")
    }

    override open var initialSubviews: [UIView] {
        return [subview()]
    }

    override open func initConstraints() {
        subview().set(.edges, .equalTo, self, .edges)
    }
}
