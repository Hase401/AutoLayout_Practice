//
//  SecondSwitcherViewController.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

//public enum BouncesType {
//    case parent
//    case child
//}

// 【メモ】ここをopenにするとエラーがなくなった
open class SecondViewController: UIViewController {

    public internal(set) var scrollViews: SecondSlideScrollView!
    public internal(set) var switcherView: SwitcherDelegate!

//    internal var safeAreaTopConstraint: NSLayoutConstraint?
//    internal var parentKeyValueObservation: NSKeyValueObservation?
//    internal var childKeyValueObservations: [String: NSKeyValueObservation] = [:]
//    internal var canParentViewScroll: Bool = true
//    internal var canChildViewScroll: Bool = false
//    internal var lastChildBouncesTranslationY: CGFloat = 0
//    internal var cachedChildViewControllerIndex: Set<Int> = Set()


    public var switcherHeight: CGFloat {
        return switcherView.ssDataSource?.height ?? 44
    }

    public var currentIndex: Int? {
        return switcherView.ssSelectedIndex
    }

//    public var currentSegementSlideContentViewController: SegementSlideContentScrollViewDelegate? {
//        guard let currentIndex = currentIndex else {
//            return nil
//        }
//        return contentView.dequeueReusableViewController(at: currentIndex)
//    }

    /// you should call `reloadData()` after set this property.
    open var defaultSelectedIndex: Int? {
        didSet {
            switcherView.ssDefaultSelectedIndex = defaultSelectedIndex
//            contentView.defaultSelectedIndex = defaultSelectedIndex
        }
    }

    open func segementSlideSwitcherView() -> SwitcherDelegate {
        #if DEBUG
        assert(false, "must override this variable")
        #endif
        return SegementSlideSwitcherEmptyView()
    }

    // overrideするための準備？
    open func setupSwitcher() {

    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSegementSlideScrollView()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    /// reload headerView, SwitcherView and ContentView
    ///
    /// you should set `defaultSelectedIndex` before call this method.
    /// otherwise, no item will be selected.
    /// however, if an item was previously selected, it will be reSelected.
    public func reloadData() {
        setupSwitcher()
        switcherView.reloadData()
        layoutSegementSlideScrollView()

//        setupBounces()
//        setupHeader()
//        setupSwitcher()
//        setupContent()
//        contentView.reloadData()
//        switcherView.reloadData()
//        layoutSegementSlideScrollView()
    }

    /// reload SwitcherView
    public func reloadSwitcher() {
        setupSwitcher()
        switcherView.reloadData()
        layoutSegementSlideScrollView()
    }

    /// select one item by index
    public func selectItem(at index: Int, animated: Bool) {
        switcherView.selectItem(at: index, animated: animated)
    }

//    deinit {
//        parentKeyValueObservation?.invalidate()
//        cleanUpChildKeyValueObservations()
//        NotificationCenter.default.removeObserver(self, name: SegementSlideContentView.willCleanUpAllReusableViewControllersNotification, object: nil)
//        #if DEBUG
//        debugPrint("\(type(of: self)) deinit")
//        #endif
//    }

}

