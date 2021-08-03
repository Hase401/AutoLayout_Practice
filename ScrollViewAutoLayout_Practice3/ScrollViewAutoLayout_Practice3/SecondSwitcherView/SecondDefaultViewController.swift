//
//  File.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

open class SecondDefaultViewController: SecondViewController {

    // ここで追加しているのがSecondDefaultSwitcherView
    private let defaultSwitcherView = SecondDefaultSwitcherView()

    // 【疑問】このDelegateはなぜ必要なのか？
    public override func segementSlideSwitcherView() -> SwitcherDelegate {
        defaultSwitcherView.delegate = self
        defaultSwitcherView.ssDataSource = self
        return defaultSwitcherView
    }

    open override func setupSwitcher() {
        super.setupSwitcher()
        // 新しく設定したものに更新する？ // ライブラリだから必要であって自作するときはいらない
        defaultSwitcherView.config = switcherConfig
    }

    open var switcherConfig: SwitcherConfig {
//        return SwitcherConfig.shared
        return ConfigManager.shared.switcherConfig // 初期から.tabにした
    }

    open override var switcherHeight: CGFloat {
        return 44
    }

    // ①titlesInSwitcher(SecondDefaultViewController: SecondViewController)
    // →②titles(SecondDefaultViewController: SwitcherDataSource)
    // →③titlesInSegementSlideSwitcherView(SecondDefaultViewController: DefaultSwitcherViewDelegate)
    // switcherView.ssDataSource?.title(SwithcerDelegateの中にあるSwitcherDataSourceのtitles)
    open var titlesInSwitcher: [String] {
//        return []
        return ["Swift", "Ruby", "Realm", "Firebase"]
    }

    // 追加
    open override func viewDidLoad() {
        super.viewDidLoad()
        // ここで最初で最後のdefaultSelectedIndexを設定していたわ笑笑
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

    // このプロパティをdelegateとして設定している理由は？
    // 【重要メモ】SecondDefaultViewControllerからSecondDefaultSwitcherViewに次のプロパティを渡すため
    public var titlesInSegementSlideSwitcherView: [String] {
        // このtitleには上にあるようにtitlesInSwitcherがある
        // nilだったら[]を返す
        return switcherView.ssDataSource?.titles ?? []
    }

}
