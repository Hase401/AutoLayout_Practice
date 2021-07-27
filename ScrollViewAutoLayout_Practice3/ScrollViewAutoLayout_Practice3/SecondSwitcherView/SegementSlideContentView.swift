//
//  SecondContentView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/26.
//

import UIKit

/// 【注意】これだけは必要みたい🔺
public protocol SegementSlideContentDelegate: AnyObject {
    var segementSlideContentScrollViewCount: Int { get }
}
