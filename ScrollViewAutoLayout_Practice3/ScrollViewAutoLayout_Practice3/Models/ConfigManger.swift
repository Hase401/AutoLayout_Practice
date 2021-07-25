//
//  ConfigManger.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

class ConfigManager {
    static let shared = ConfigManager()

    let switcherConfig: SwitcherConfig

    init() {
        switcherConfig = SwitcherConfig(
            normalTitleColor: UIColor.gray,
            selectedTitleColor: UIColor.blue,
            indicatorColor: UIColor.orange
        )
    }
}
