//
//  SecondSwitcherView+ex.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

private var dataSourceKey: Void?

extension SecondDefaultSwitcherView: SwitcherDelegate {

    public weak var ssDataSource: SwitcherDataSource? {
        get {
            let weakBox = objc_getAssociatedObject(self, &dataSourceKey) as? SwitcherDataSourceWeakBox
            return weakBox?.unbox
        }
        set {
            objc_setAssociatedObject(self, &dataSourceKey, SwitcherDataSourceWeakBox(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public var ssDefaultSelectedIndex: Int? {
        get {
            return defaultSelectedIndex
        }
        set {
            defaultSelectedIndex = newValue
        }
    }

    public var ssSelectedIndex: Int? {
        return selectedIndex
    }

//    public var ssScrollView: UIScrollView {
//        return scrollView
//    }

}
