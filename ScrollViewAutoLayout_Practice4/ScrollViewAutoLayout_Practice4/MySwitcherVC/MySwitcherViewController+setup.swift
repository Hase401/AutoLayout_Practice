//
//  MySwitcherViewController+setup.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/04.
//

import UIKit

extension MySwitcherViewController {

    internal func layoutSegementSlideScrollView() {

        // 【メモ】これを一番最初に置くと良さそう
        // addSubviewしてから色々な成約をつけるという順番？
        self.view.addSubview(mySwitcherView)

        /// これは必須
        mySwitcherView.translatesAutoresizingMaskIntoConstraints = false

        // 【エラー】Value of type 'MySwitcherView' has no member 'topConstraint'
        // これがあると紫の警告が消える？？
        if mySwitcherView.topConstraint == nil {
            mySwitcherView.topConstraint = mySwitcherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44*2)
        }

        if mySwitcherView.leadingConstraint == nil {
            mySwitcherView.leadingConstraint = mySwitcherView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
        if mySwitcherView.trailingConstraint == nil {
            mySwitcherView.trailingConstraint = mySwitcherView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
        if mySwitcherView.heightConstraint == nil {
            mySwitcherView.heightConstraint = mySwitcherView.heightAnchor.constraint(equalToConstant: switcherHeight)
        } else {
            if mySwitcherView.heightConstraint?.constant != switcherHeight {
                mySwitcherView.heightConstraint?.constant = switcherHeight
            }
        }
    }

//    internal func setup() {
////        self.view.addSubview(mySwitcherView)
//        // この制約がないと上手くいかない
////        mySwitcherView.constraintToSuperview()
//    }
}
