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
//        return SwitcherConfig.shared
        return ConfigManager.shared.switcherConfig // 初期から.tabにした
    }

    open override var switcherHeight: CGFloat {
        return 44
    }

    open var titlesInSwitcher: [String] {
//        return []
        return ["Swift", "Ruby", "Realm", "Firebase"]
    }

    // 追加
    open override func viewDidLoad() {
        super.viewDidLoad()
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

    public var titlesInSegementSlideSwitcherView: [String] {
        return switcherView.ssDataSource?.titles ?? []
    }

}
