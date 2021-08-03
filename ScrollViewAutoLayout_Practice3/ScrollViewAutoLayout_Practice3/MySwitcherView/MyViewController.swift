//
//  MyViewController.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/03.
//

import UIKit


final class MyViewController: UIViewController {

    public let mySwitcherView = MySwitcherView()

    public var switcherHeight: CGFloat {
        return 44
    }

    // 【メモ】オプショナル型にしない代入できない？
    public var titleMySwitcherView: [String]? = []


    // ビューがそのサブビューをレイアウトした後に変更できる
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // これがないとMyViewControllerでMySwitcerViewなどが表示できない
        // 前にやったものは、UIViewをsuperViewとしたときのLayoutSubviews()、今回は、ViewControllerのライフサイクル
        // これがなかったのが表示されなかった原因？ →これ呼ばないとビュー階層に表示されない
        // けど、中身を表示するのはこれではないらしい
        layoutSegementSlideScrollView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectedIndex = 0
        titleMySwitcherView = mySwitcherView.titlesInSegementSlideSwitcherView // 上手く渡せている
        // これを呼ばないとScrollViewの中身にButtonが入らない
        mySwitcherView.reloadData()
        // ここで呼んで見る
//        setup()
    }

    // 【error】Members of 'final' classes are implicitly 'final'; use 'public' instead of 'open'
    // 【解決策】open(継承可)　→　public or internal　へ
    public var defaultSelectedIndex: Int? {
        didSet {
            // 【疑問】didSetということは後から変更するということ？
            // 使われているのは、ViewDidLoadでdefaultSelectedIndex = 0 として読んだところのみ
            mySwitcherView.defaultSelectedIndex = defaultSelectedIndex
        }
    }
    
}
