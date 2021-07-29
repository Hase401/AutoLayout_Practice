//
//  ex.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

extension SecondViewController {

    internal func setup() {
        // 【メモ】なぜかsetupSegementSlideViewsをコメントアウトしていたから、nilになっていたかも
        setupSegementSlideViews()
        setupSegementSlideScrollView()
        setupSegementSlideSwitcherView()
    }

    private func setupSegementSlideViews() {
        switcherView = segementSlideSwitcherView() // これはメソッド
        var gestureRecognizers: [UIGestureRecognizer] = []

        // これは削除しても平気
//        if let gestureRecognizersInScrollView = switcherView.ssScrollView.gestureRecognizers {
//            gestureRecognizers.append(contentsOf: gestureRecognizersInScrollView)
//        }

        // 【メモ】これでnilじゃなくなるかも
        scrollViews = SecondSlideScrollView(otherGestureRecognizers: gestureRecognizers)
    }

    internal func setupSegementSlideSwitcherView() {
        scrollViews.addSubview(switcherView)
    }

    private func setupSegementSlideScrollView() {
        view.addSubview(scrollViews)
        scrollViews.constraintToSuperview()
        // 【疑問】ほんとに関係ないのかわからないけど、削除しても動く
//        scrollViews.backgroundColor = .white
//        scrollViews.showsHorizontalScrollIndicator = false
//        scrollViews.showsVerticalScrollIndicator = false
//        scrollViews.isPagingEnabled = false
//        scrollViews.isScrollEnabled = true
//        scrollViews.scrollsToTop = true
        // 削除⭕　後々使うかも
//        scrollView.delegate = self
    }

    internal func layoutSegementSlideScrollView() {

        /// これは重要そうで必須
        switcherView.translatesAutoresizingMaskIntoConstraints = false

        // 以下の必要
        if switcherView.leadingConstraint == nil {
            switcherView.leadingConstraint = switcherView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
        if switcherView.trailingConstraint == nil {
            switcherView.trailingConstraint = switcherView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
        if switcherView.heightConstraint == nil {
            switcherView.heightConstraint = switcherView.heightAnchor.constraint(equalToConstant: switcherHeight)
        } else {
            if switcherView.heightConstraint?.constant != switcherHeight {
                switcherView.heightConstraint?.constant = switcherHeight
            }
        }
    }

}
