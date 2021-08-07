//
//  ViewController.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/04.
//

import UIKit


final class MySwitcherViewController: UIViewController {

    let mySwitcherView = MySwitcherView()
    let mySwitcherContentView = MySwitcherContentView()
    // 【疑問】これはどんな型？ 配列の順序が関係なバージョン
    var cachedChildViewControllerIndex: Set<Int> = Set()

    var switcherHeight: CGFloat {
        return 44 // getのみ
    }

    // 【メモ】オプショナル型にしない代入できない？
    var titleMySwitcherView: [String]? = []
    // 【error】Members of 'final' classes are implicitly 'final'; use 'public' instead of 'open'
    // 【解決策】open(継承可)　→　public or internal　へ
    var defaultSelectedIndex: Int? {
        didSet {
            // 【疑問】didSetということは後から変更するということ？
            // 使われているのは、ViewDidLoadでdefaultSelectedIndex = 0 として読んだところのみ
            mySwitcherView.defaultSelectedIndex = defaultSelectedIndex
            mySwitcherContentView.defaultSelectedIndex = defaultSelectedIndex
        }
    }
    var currentIndex: Int? {
        // これでいいのか？nilが初期値となる？
    // 【疑問】setがないからselectedIndexが変わってもこの値は変わらない？？ // getだけでも値は変わるんだっけか、、！？
        return mySwitcherView.selectedIndex
    }
    var currentSegementSlideContentViewController: ContentViewDelegate? {
        guard let currentIndex = currentIndex else {
            return nil
        }
        return mySwitcherContentView.dequeueReusableViewController(at: currentIndex)
    }


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
        setup()
        defaultSelectedIndex = 0
        titleMySwitcherView = mySwitcherView.titlesInSegementSlideSwitcherView // 上手く渡せている
        // これを呼ばないとScrollViewの中身にButtonが入らない
        mySwitcherView.reloadData()
    }

    func segementSlideContentViewController(at index: Int) -> ContentViewDelegate? {
        // 【エラー】これだとstroyboardから読み込めないためエラーが出る
//        let contentVC = ContentViewController()
        let contentVC = UIStoryboard(name: "ContentViewController", bundle: nil)
                            .instantiateInitialViewController() as! ContentViewController
        // 【エラー】ContentViewControllerにContentViewDelegateを継承させないと次のエラー
        // Type of expression is ambiguous without more context
        return contentVC
    }

}
