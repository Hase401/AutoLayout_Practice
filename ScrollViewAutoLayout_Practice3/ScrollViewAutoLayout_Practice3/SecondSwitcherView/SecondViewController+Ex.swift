//
//  ex.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

extension SecondViewController {

    internal func setup() {
        view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = []
        // 【メモ】なぜかsetupSegementSlideViewsをコメントアウトしていたから、nilになっていたかも
        setupSegementSlideViews()
        setupSegementSlideScrollView()
        setupSegementSlideSwitcherView()
//        observeScrollViewContentOffset()
//        observeWillCleanUpAllReusableViewControllersNotification()
    }

    private func setupSegementSlideViews() {
        switcherView = segementSlideSwitcherView() // これはメソッド
        var gestureRecognizers: [UIGestureRecognizer] = []
        if let gestureRecognizersInScrollView = switcherView.ssScrollView.gestureRecognizers {
            gestureRecognizers.append(contentsOf: gestureRecognizersInScrollView)
        }
        // 【メモ】これでnilじゃなくなるかも
        scrollViews = SecondSlideScrollView(otherGestureRecognizers: gestureRecognizers)
    }

    internal func setupSegementSlideSwitcherView() {
        scrollViews.addSubview(switcherView)
    }

    private func setupSegementSlideScrollView() {
//        print(scrollViews)
        view.addSubview(scrollViews)
        scrollViews.constraintToSuperview()
        // 削除?
//        if #available(iOS 11.0, *) {
//            scrollView.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        scrollViews.backgroundColor = .white
        scrollViews.showsHorizontalScrollIndicator = false
        scrollViews.showsVerticalScrollIndicator = false
        scrollViews.isPagingEnabled = false
        scrollViews.isScrollEnabled = true
        scrollViews.scrollsToTop = true
        // 【疑問】
//        scrollView.delegate = self
    }

    // スクロールしたときの挙動？parentってなんだ？
//    private func observeScrollViewContentOffset() {
//        parentKeyValueObservation = scrollView.observe(\.contentOffset, options: [.initial, .new, .old], changeHandler: { [weak self] (scrollView, change) in
//            guard let self = self else {
//                return
//            }
//            guard change.newValue != change.oldValue else {
//                return
//            }
//            self.parentScrollViewDidScroll(scrollView)
//        })
//    }

//    private func observeWillCleanUpAllReusableViewControllersNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(willCleanUpAllReusableViewControllers(_:)), name: SegementSlideContentView.willCleanUpAllReusableViewControllersNotification, object: nil)
//    }

    internal func layoutSegementSlideScrollView() {
//        let topLayoutLength: CGFloat
//        if edgesForExtendedLayout.contains(.top) {
//            topLayoutLength = 0
//        } else {
//            topLayoutLength = self.topLayoutLength
//        }
//
//        switcherView.translatesAutoresizingMaskIntoConstraints = false
//        if switcherView.topConstraint == nil {
//            let topConstraint = switcherView.topAnchor.constraint(equalTo: headerView.bottomAnchor)
//            topConstraint.priority = UILayoutPriority(rawValue: 999)
//            switcherView.topConstraint = topConstraint
//        }
//        if safeAreaTopConstraint == nil {
//            safeAreaTopConstraint?.isActive = false
//            if #available(iOS 11, *) {
//                safeAreaTopConstraint = switcherView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor)
//            } else {
//                safeAreaTopConstraint = switcherView.topAnchor.constraint(greaterThanOrEqualTo: topLayoutGuide.bottomAnchor)
//            }
//            safeAreaTopConstraint?.isActive = true
//        }
        
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

        // contentは違う気がする
//        if scrollView.contentSize != contentSize {
//            scrollView.contentSize = contentSize
//        }
    }

}
