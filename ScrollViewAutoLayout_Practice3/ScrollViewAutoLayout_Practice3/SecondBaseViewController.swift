//
//  SecondBaseViewController.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

class SecondBaseViewController: SecondDefaultViewController {

/// 【疑問】Baseにはまだ書かない？
//    override var titlesInSwitcher: [String] {
//        ["Swift", "Ruby", "Realm", "Firebase"]
//    }

    override var switcherConfig: SwitcherConfig {
        return ConfigManager.shared.switcherConfig
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
    }

    /// 【重要】navigationItemの設定
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("\(type(of: self)) - \(String(format: "%p", self)) - \(#function)")
    }

}
