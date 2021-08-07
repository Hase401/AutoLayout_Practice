//
//  MySwitcherViewController+setup.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/04.
//

import UIKit

extension MySwitcherViewController {

    // まだ使わなくても大丈夫
    func setup() {
        setupSegementSlideSwitcherView()
        setupSegementSlideContentView()
    }

    func setupSegementSlideSwitcherView() {
        // addSubviewしてから色々な成約をつけるという順番？
        // 【重要メモ】このSwitcherViewでのdelegateはswitcherViewのdelegateが終わったあとにしよう
        mySwitcherView.delegate = self
        self.view.addSubview(mySwitcherView)
    }

    func setupSegementSlideContentView() {
        mySwitcherContentView.delegate = self
        // ここviewControllerを使ってSegementSlideViewController(self)を渡していたんだ、、
        mySwitcherContentView.viewController = self
        self.view.addSubview(mySwitcherContentView)
    }


    func layoutSegementSlideScrollView() {
        /// これは必須
        mySwitcherView.translatesAutoresizingMaskIntoConstraints = false
        // 【エラー】Value of type 'MySwitcherView' has no member 'topConstraint' // Extensionのおかげ？
        // これがあると紫の警告が消える？？
        if mySwitcherView.topConstraint == nil {
            mySwitcherView.topConstraint = mySwitcherView.topAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor)
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


        mySwitcherContentView.translatesAutoresizingMaskIntoConstraints = false
        if mySwitcherContentView.topConstraint == nil {
            mySwitcherContentView.topConstraint = mySwitcherContentView.topAnchor.constraint(equalTo: mySwitcherView.bottomAnchor)
        }
        if mySwitcherContentView.leadingConstraint == nil {
            mySwitcherContentView.leadingConstraint = mySwitcherContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
        if mySwitcherContentView.trailingConstraint == nil {
            mySwitcherContentView.trailingConstraint = mySwitcherContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
        if mySwitcherContentView.bottomConstraint == nil {
            mySwitcherContentView.bottomConstraint = mySwitcherContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }

        mySwitcherView.layer.zPosition = -1
        mySwitcherContentView.layer.zPosition = -2

    }
}
