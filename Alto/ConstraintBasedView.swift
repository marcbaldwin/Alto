import UIKit

open class ConstraintBasedView: UIView {
    
    open var hasInitConstraints = false

    public init() {
        super.init(frame: .zero)
        initViewIfRequired()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewIfRequired()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViewIfRequired()
    }

    override open class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override open func updateConstraints() {
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
        super.updateConstraints()
    }

    open func initViewInInit() -> Bool {
        return true
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

    private func initViewIfRequired() {
        if initViewInInit() {
            initView()
        }
    }
}
