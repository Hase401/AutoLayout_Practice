//
//  HomeViewController.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/26.
//

import UIKit

class HomesViewController: SecondBaseViewController {

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var switcherConfig: SwitcherConfig {
        var config = super.switcherConfig
        config.type = .tab
        return config
    }

    override var titlesInSwitcher: [String] {
        ["Swift", "Ruby", "Realm", "Firebase"]
    }

    /// 【重要】これで自由にheaderがつけれるようになる
    // 【メモ】ここでgithubみたいに簡単に記録が見れたらあがる！！
//    override func segementSlideHeaderView() -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .purple // 紫はpurple
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
//        return headerView
//    }

    /// 【重要】ここで様々なcontentVCを作ってif文などでslideごとにわける
//    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
//        let contentVC = ContentViewController()
//        contentVC.configure(color: languages[index].color)
//        return contentVC
//    }

    // 値を渡すのは、viewDidLoadではすでに遅い
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectedIndex = 0
        reloadData()
    }
}

