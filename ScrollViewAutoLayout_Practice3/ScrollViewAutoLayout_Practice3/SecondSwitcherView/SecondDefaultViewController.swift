//
//  File.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

open class SecondDefaultViewController: SecondViewController {

    private let defaultSwitcherView = SecondDefaultSwitcherView()

    public override func segementSlideSwitcherView() -> SwitcherDelegate {
        defaultSwitcherView.delegate = self
        defaultSwitcherView.ssDataSource = self
        return defaultSwitcherView
    }

    open override func setupSwitcher() {
        super.setupSwitcher()
        defaultSwitcherView.config = switcherConfig
    }

    open var switcherConfig: SwitcherConfig {
        return SwitcherConfig.shared
    }

    open override var switcherHeight: CGFloat {
        return 44
    }

    open var titlesInSwitcher: [String] {
        return []
    }


//    open override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
//    }
//
//    open override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
//    }
//
//    open override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
//    }
//
//    open override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
//    }
//
    open override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")

        defaultSelectedIndex = 0
        reloadData()
    }


}

extension SecondDefaultViewController: SwitcherDataSource {

    public var height: CGFloat {
        return switcherHeight
    }

    public var titles: [String] {
        return titlesInSwitcher
    }

}

extension SecondDefaultViewController: DefaultSwitcherViewDelegate {
    public func segementSwitcherView(_ segementSlideSwitcherView: SecondDefaultSwitcherView, didSelectAtIndex index: Int, animated: Bool) {
//        if contentView.selectedIndex != index {
//            contentView.selectItem(at: index, animated: animated)
//        }
    }


    public var titlesInSegementSlideSwitcherView: [String] {
        return switcherView.ssDataSource?.titles ?? []
    }

//    public func segementSwitcherView(_ segementSlideSwitcherView: SecondSwitcherView, didSelectAtIndex index: Int, animated: Bool) {
//        if contentView.selectedIndex != index {
//            contentView.selectItem(at: index, animated: animated)
//        }
//    }

//    public func segementSwitcherView(_ segementSlideSwitcherView: SegementSlideDefaultSwitcherView, showBadgeAtIndex index: Int) -> BadgeType {
//        return showBadgeInSwitcher(at: index)
//    }

}
