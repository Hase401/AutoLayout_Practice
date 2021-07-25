//
//  SecondBaseViewController.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

class SecondBaseViewController: SecondDefaultViewController {


    override var titlesInSwitcher: [String] {
        ["Swift", "Ruby", "Realm", "Firebase"]
    }

    override var switcherConfig: SwitcherConfig {
        return ConfigManager.shared.switcherConfig
    }
//    override var switcherConfig: SwitcherConfig {
//        var config = super.switcherConfig
//        config.type = .tab
//        return config
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectedIndex = 0
        reloadData()
    }

}
