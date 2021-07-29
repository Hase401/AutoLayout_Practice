//
//  SwitcherConfig.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

public struct SwitcherConfig {

    public static let shared = SwitcherConfig()

    public var type: SwitcherType
    public var horizontalMargin: CGFloat
    public var horizontalSpace: CGFloat
    public var normalTitleFont: UIFont
    public var selectedTitleFont: UIFont
    public var normalTitleColor: UIColor
    public var selectedTitleColor: UIColor
    public var indicatorWidth: CGFloat
    public var indicatorHeight: CGFloat
    public var indicatorColor: UIColor

    public init(type: SwitcherType = .tab,
                horizontalMargin: CGFloat = 16,
                horizontalSpace: CGFloat = 32,
                normalTitleFont: UIFont = UIFont.systemFont(ofSize: 15),
                selectedTitleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium),
                normalTitleColor: UIColor = UIColor.gray,
                selectedTitleColor: UIColor = UIColor.darkGray,
                indicatorWidth: CGFloat = 30,
                indicatorHeight: CGFloat = 2,
                indicatorColor: UIColor = UIColor.darkGray) {
        self.type = type
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
