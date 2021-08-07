//
//  MySwticherContentView.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/04.
//

import UIKit

// 【メモ】プロトコルでviewControllersの中身の型を設定できるのではないか？
public protocol ContentViewDelegate where Self: UIViewController {

}

// 【重要メモ】ここをpublicにするとMySwitcherContentViewのアクセスが合わなくてエラー
protocol SegementSlideContentDelegate: AnyObject {
    var segementSlideContentScrollViewCount: Int { get }
//
//    // これでHomesViewControllerに(SegementSlideViewControllerを)継承して実行している
    func segementSlideContentScrollView(at index: Int) -> ContentViewDelegate?

}


final class MySwitcherContentView: UIView {
    private(set) var scrollView = UIScrollView()
    // できればUIViewControllerではなくて、ContentViewControllerを入れるべき？
    private var viewControllers: [Int: ContentViewDelegate] = [:]

    /// you should call `reloadData()` after set this property.
    var defaultSelectedIndex: Int?
    private(set) var selectedIndex: Int?
    // 親となるViewControllerを格納しておくためのプロパティ(弱参照)
    // 【疑問①】本当に必要？　→updateSelectedViewController()を読む
    weak var viewController: UIViewController?
    // 【疑問②】本当に必要？ →updateSelectedViewController()を読む
    weak var delegate: SegementSlideContentDelegate?

    // 【疑問】scrollViewの中のプロパティをContentViewのスコープ内にも持たせたい！？
    public var isScrollEnabled: Bool {
        get {
            return scrollView.isScrollEnabled
        }
        set {
            scrollView.isScrollEnabled = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(scrollView)
        scrollView.constraintToSuperview()
//        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        backgroundColor = .white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectedIndex()
    }

    /// select one item by index
    // mySwitcherViewのdelegateで呼ばれる実際のメソッド
    func selectItem(at index: Int, animated: Bool) {
        updateSelectedViewController(at: index, animated: animated)
    }

    /// reuse the `ContentViewDelegate`// 再利用する
    // 【メモ】同じ名前のメソッドがviewControllerにもある
    // プロトコルによってContentViewDelegate == ContentViewControllerにできるという推測での話
    func dequeueReusableViewController(at index: Int) -> ContentViewDelegate? {
        // childViewController: ContentViewDelegate
        if let childViewController = viewControllers[index] {
            // viewControllers[index]がnilではないとき
            return childViewController
        } else {
            // viewControllers[index]がnilのとき
            // ContentViewDelegate(ContentVC)もnilを返す
            return nil
        }
    }
}

//extension MySwitcherContentView: UIScrollViewDelegate {
//
//    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if decelerate { return }
//        scrollViewDidEndScroll(scrollView)
//    }
//
//    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        scrollViewDidEndScroll(scrollView)
//    }
//
//    private func scrollViewDidEndScroll(_ scrollView: UIScrollView) {
//        let indexFloat = scrollView.contentOffset.x/scrollView.bounds.width
//        guard !indexFloat.isNaN, indexFloat.isFinite else {
//            return
//        }
//        let index = Int(indexFloat)
//        updateSelectedViewController(at: index, animated: true)
//    }
//
//}

extension MySwitcherContentView {

    private func updateSelectedIndex() {
        if let index = selectedIndex  {
            updateSelectedViewController(at: index, animated: false)
        } else if let index = defaultSelectedIndex {
            updateSelectedViewController(at: index, animated: false)
        }
    }

    // これと同じ名前のものがVCにもあるけど、、無視かな、、
    // とりあえず、今のindexのViewControllerをchildViewController(ContentViewDelegteを継承したUIViewControllerとして返している)
    private func segementSlideContentViewController(at index: Int) -> ContentViewDelegate? {
        if let childViewController = dequeueReusableViewController(at: index) {
            // viewControllers(配列)に何かしらある(つまりnil)ではないなら、そのContentViewDelegateを返す
            return childViewController
        } else if let childViewController = delegate?.segementSlideContentScrollView(at: index) { // delegateでcontentVCを返す
            viewControllers[index] = childViewController
            return childViewController
        }
        return nil
    }

    // これが上手く機能していない可能性
    private func updateSelectedViewController(at index: Int, animated: Bool) {
        // frameが0だったらreturnさせる
        guard scrollView.frame != .zero else {
            return
        }
        // 同じところをタップしたらなら（すでにindex = selectedIndexだったら）returnさせる
        guard index != selectedIndex else {
            return
        }
        let count = delegate?.segementSlideContentScrollViewCount ?? 0
        print("count", count)
        if let selectedIndex = selectedIndex {
            guard selectedIndex >= 0, selectedIndex < count else {
                return
            }
        }
        // 【疑問】ここに上のViewControllerを渡して何に使うんだろう？
        guard let viewController = viewController,
            index >= 0, index < count else {
            return
        }

        // 前に選択しているindexがselectedIndex
        // 【メモ】ライフサイクルの更新始まり?
        if let lastIndex = selectedIndex,
           let lastChildViewController = segementSlideContentViewController(at: lastIndex) {
            // もしnilだったら、、
            // last child viewController viewWillDisappear
            // 子のビューが現れたり消えたりするのを伝えます。viewWillAppear(_:), viewWillDisappear(_:), viewDidAppear(_:), viewDidDisappear(_:) を直接起動しない
            // 子ビューコントローラのビューがビュー階層に追加されようとしている場合はtrue
            // 削除されようとしている場合はfalse
            lastChildViewController.beginAppearanceTransition(false, animated: animated)
        }
        guard let childViewController = segementSlideContentViewController(at: index) else {
            return
        }
        // superViewがnilじゃないならtrue // nilならfalse
        let isAdded = childViewController.view.superview != nil // Bool値
        if !isAdded {
            // superviewがnilなら、、subviewに追加する？ // 【疑問】superviewどうなってんの？
            // new child viewController viewDidLoad, viewWillAppear
            viewController.addChild(childViewController)
            scrollView.addSubview(childViewController.view)
        } else {
            // superviewがnilじゃないなら、現在のchildVCのviewWillAppearが呼ばれる？
            // current child viewController viewWillAppear
            childViewController.beginAppearanceTransition(true, animated: animated)
        }
        // viewControllerの数(buttonの数)だけ横幅がある
        let offsetX = CGFloat(index)*scrollView.bounds.width
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.topConstraint = childViewController.view.topAnchor.constraint(equalTo: scrollView.topAnchor)
        childViewController.view.widthConstraint = childViewController.view.widthAnchor.constraint(equalToConstant: scrollView.bounds.width)
        childViewController.view.heightConstraint = childViewController.view.heightAnchor.constraint(equalToConstant: scrollView.bounds.height)
        childViewController.view.leadingConstraint = childViewController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: offsetX)
        // 【疑問】これは何？
        // 受信者の原点に対応するコンテンツビューの原点からのオフセットを設定
        // setContentOffsetで横にスクロールできるScrollViewの始まりを指摘しているのかな？
        scrollView.setContentOffset(CGPoint(x: offsetX, y: scrollView.contentOffset.y), animated: animated)
        // 【メモ】ライフサイクルの更新終わり?
        if let lastIndex = selectedIndex,
           let lastChildViewController = segementSlideContentViewController(at: lastIndex) {
            // last child viewController viewDidDisappear
            lastChildViewController.endAppearanceTransition()
        }

        if !isAdded {
            ()
        } else {
            // current child viewController viewDidAppear
            childViewController.endAppearanceTransition()
        }
        selectedIndex = index

        // 【新重要メモ】恐らくこれでスクロールしたときのswitcherViewを呼んで表示するように設定している
        // プロトコルに新しくsegementSlideContentView()のメソッドを追加する必要がある
//        delegate?.segementSlideContentView(self, didSelectAtIndex: index, animated: animated)
    }
}
