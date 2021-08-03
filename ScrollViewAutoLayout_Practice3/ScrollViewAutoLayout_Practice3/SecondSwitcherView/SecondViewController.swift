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

// 【メモ】一番の基本的な部分
// 【メモ】ここをopenにするとエラーがなくなった
open class SecondViewController: UIViewController {

    public internal(set) var scrollViews: SecondSlideScrollView!
    public internal(set) var switcherView: SwitcherDelegate!

    // 削除⭕
//    internal var safeAreaTopConstraint: NSLayoutConstraint?

    public var switcherHeight: CGFloat {
        return switcherView.ssDataSource?.height ?? 44
    }
//
//    public var currentIndex: Int? {
//        return switcherView.ssSelectedIndex
//    }

    /// you should call `reloadData()` after set this property.
    // ここで最初のdefaultSelectedIndexを入れている？
    // defaultSelectedIndexに再代入しているところは今のところない！！
    open var defaultSelectedIndex: Int? {
        didSet {
            switcherView.ssDefaultSelectedIndex = defaultSelectedIndex
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
        // これも必須
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
    }

    /// reload SwitcherView
    public func reloadSwitcher() {
        setupSwitcher()
        switcherView.reloadData()
    }

    // 削除⭕
//    /// select one item by index
//    public func selectItem(at index: Int, animated: Bool) {
//        switcherView.selectItem(at: index, animated: animated)
//    }

}

