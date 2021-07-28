//
//  SegementSlideViewController+ex.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/27.
//

import UIKit

extension SecondViewController {

    internal var topLayoutLength: CGFloat {
        let topLayoutLength: CGFloat
        if #available(iOS 11, *) {
            topLayoutLength = view.safeAreaInsets.top
        } else {
            topLayoutLength = topLayoutGuide.length
        }
        return topLayoutLength
    }

    internal var bottomLayoutLength: CGFloat {
        let bottomLayoutLength: CGFloat
        if #available(iOS 11, *) {
            bottomLayoutLength = view.safeAreaInsets.bottom
        } else {
            bottomLayoutLength = bottomLayoutGuide.length
        }
        return bottomLayoutLength
    }

}
