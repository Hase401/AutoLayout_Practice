//
//  MySwticherContentView.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/04.
//

import UIKit

final class MySwitcherContentView: UIView {
    public private(set) var scrollView = UIScrollView()
    // できればUIViewControllerではなくて、ContentViewControllerを入れるべき？
    private var viewControllers: [Int: UIViewController] = [:]

    /// you should call `reloadData()` after set this property.
    public var defaultSelectedIndex: Int?
    public private(set) var selectedIndex: Int?
//    public weak var viewController: UIViewController?
    public var isScrollEnabled: Bool {
        get {
            return scrollView.isScrollEnabled
        }
        set {
            scrollView.isScrollEnabled = newValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(scrollView)
        scrollView.constraintToSuperview()
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        backgroundColor = .white
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
//        updateScrollViewContentSize()
//        layoutViewControllers()
//        updateSelectedIndex()
    }

    /// remove subViews
    ///
    /// you should set `defaultSelectedIndex` before call this method.
    /// otherwise, no item will be selected.
    /// however, if an item was previously selected, it will be reSelected.
    public func reloadData() {
//        cleanUpAllReusableViewControllers()
//        updateScrollViewContentSize()
//        reloadDataWithSelectedIndex()
    }

    /// select one item by index
    public func selectItem(at index: Int, animated: Bool) {
//        updateSelectedViewController(at: index, animated: animated)
    }

    /// reuse the `SegementSlideContentScrollViewDelegate`
//    public func dequeueReusableViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
//        if let childViewController = viewControllers[index] {
//            return childViewController
//        } else {
//            return nil
//        }
//    }
}
