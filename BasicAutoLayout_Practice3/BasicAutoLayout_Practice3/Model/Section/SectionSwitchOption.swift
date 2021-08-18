//
//  SectionSwitchOption.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/13.
//

import UIKit

struct SectionSwitchOption {
    let title: String
    let icon: UIImage? // nilは"設定していない"を表す
    let iconBackgroundColor: UIColor
    let hander: () -> Void
    // 追加
    var isOn: Bool
}
