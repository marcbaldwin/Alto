import UIKit

open class ConstraintBasedTableViewCell: UITableViewCell {

    open var boundObjectId: String?
    open var hasInitConstraints = false

    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }

    required public init?(coder aDecoder: NSCoder) { fatalError() }

    override open func updateConstraints() {
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
        super.updateConstraints()
    }

    open func initView() {
        initialSubviews().forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        setNeedsUpdateConstraints()
    }

    open func initConstraints() { }

    open func initialSubviews() -> [UIView] { return [UIView]() }
}

open class ViewHolderTableViewCell: ConstraintBasedTableViewCell {

    open func subview() -> UIView {
        fatalError("subview is abstract")
    }

    override open func initialSubviews() -> [UIView] {
        return [subview()]
    }

    override open func initConstraints() {
        subview().set(.edges, .equalTo, self, .edges)
    }
}
