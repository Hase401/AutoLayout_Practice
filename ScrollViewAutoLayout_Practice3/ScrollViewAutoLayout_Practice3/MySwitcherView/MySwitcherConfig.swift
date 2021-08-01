//
//  MySwitcherConfig.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/01.

import UIKit

struct MySwitcherConfig {

    var horizontalMargin: CGFloat
    var horizontalSpace: CGFloat
    var normalTitleFont: UIFont
    var selectedTitleFont: UIFont
    var normalTitleColor: UIColor
    var selectedTitleColor: UIColor
    // indicator
    var indicatorWidth: CGFloat
    var indicatorHeight: CGFloat
    var indicatorColor: UIColor


    // 【疑問】最初から初期値として与えておくのは、良くないのか？
    init(horizontalMargin: CGFloat = 16,
         horizontalSpace: CGFloat = 32,
         normalTitleFont: UIFont = UIFont.systemFont(ofSize: 15),
         selectedTitleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium),
         normalTitleColor: UIColor = UIColor.gray,
         selectedTitleColor: UIColor = UIColor.darkGray,
         indicatorWidth: CGFloat = 30,
         indicatorHeight: CGFloat = 2,
         indicatorColor: UIColor = UIColor.darkGray) {
        self.horizontalMargin = horizontalMargin
        self.horizontalSpace = horizontalSpace
        self.normalTitleFont = normalTitleFont
        self.selectedTitleFont = selectedTitleFont
        self.normalTitleColor = normalTitleColor
        self.selectedTitleColor = selectedTitleColor
        self.indicatorWidth = indicatorWidth
        self.indicatorHeight = indicatorHeight
        self.indicatorColor = indicatorColor
    }
}
