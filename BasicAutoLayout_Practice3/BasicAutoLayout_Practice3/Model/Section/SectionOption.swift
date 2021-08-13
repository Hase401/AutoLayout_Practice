//
//  SectionOption.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/13.
//

import UIKit

struct SectionOption {
    let title: String
    let icon: UIImage? // nilは"設定していない"を表す
    let iconBackgroundColor: UIColor
    let hander: () -> Void
}
