//
//  SegementSlideViewController+delegate.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/26.
//

import UIKit

extension SecondViewController: UIScrollViewDelegate {

    // 【疑問】空のメソッドを読んでいるから実際delegateいらなそう
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
//        resetScrollViewStatus()
//        resetCurrentChildViewControllerContentOffsetY()
        return true
    }

}

extension SecondViewController: SegementSlideContentDelegate {

    public var segementSlideContentScrollViewCount: Int {
        return switcherView.ssDataSource?.titles.count ?? 0
    }

}
