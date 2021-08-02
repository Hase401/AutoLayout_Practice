//
//  MyDefaultSwitcherView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/31.
//

import UIKit

// カスタムViewなのでイニシャライザが必要？
class MySwitcherView: UIView {

    var scrollView = UIScrollView()
    private let indicatorView = UIView()
    // 【疑問】どこで中身を代入しているのか
    private var titleButtons: [UIButton] = []
    // 【疑問】classではなく、structで共通化する方法どうするんだっけ？(あきおさんがやっていた気がする)
    private var innerConfig: MySwitcherConfig = MySwitcherConfig()

    // 【重要メモ】プロトコルのdelegateでプロパテを置く意味があんまりわからなかったので、自分で試しにここにおいてみる
    // 【メモ】オプショナル型にしないとguard letが使えない
    var titlesInSegementSlideSwitcherView: [String]?

    /// you should call `reloadData()` after set this property.
    // 【疑問】どこでこのプロパティをセットしているのか
    var defaultSelectedIndex: Int?
    var selectedIndex: Int?

    // 親のUIViewのプロパティ
    override var intrinsicContentSize: CGSize {
        return scrollView.contentSize
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
        addSubview(scrollView) // 一番上にscrollViewがある
        scrollView.constraintToSuperview()
        // 水平スクロールインジケータが表示されているかどうかを制御するブール値
        scrollView.showsHorizontalScrollIndicator = false
        // 垂直スクロールインジケータが表示されているかどうかを制御するブール値
        scrollView.showsVerticalScrollIndicator = false
        // 上部へのスクロールジェスチャーを有効にするかどうかを制御するブール値
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = .clear
        backgroundColor = .white // self.backgroundColorかな
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        reloadContents()
//        updateSelectedIndex()
    }

    public func reloadData() {
//        reloadSubViews()
    }

    // 【疑問】どこで読んでいるのか→@objcでボタンから読んでいる // 2ドデマでは？
    public func selectItem(at index: Int, animated: Bool) {
//        updateSelectedButton(at: index, animated: animated)
    }
    
}

extension MySwitcherView {

    private func updateSelectedIndex() {
        if let index = selectedIndex  {
            updateSelectedButton(at: index, animated: false)
        } else if let index = defaultSelectedIndex {
            updateSelectedButton(at: index, animated: false)
        }
    }

    /// buttonとindicatorViewをscrollView.addSubView()する
    private func reloadSubViews() {

        /// 初期化？実際なくても動く！！よくわからない。。。
        for titleButton in titleButtons {
            // スーパービューおよびウィンドウからビューのリンクを解除し、レスポンダチェーンからビューを削除
            titleButton.removeFromSuperview()
            titleButton.frame = .zero
        }
        // 【疑問メモ】コレクションからすべての要素を削除
        titleButtons.removeAll()
        indicatorView.removeFromSuperview()
        indicatorView.frame = .zero
        // 削除？ なんで同じものを渡していたのか？
//        innerConfig = config

        // 削除
//        guard let titles = delegate?.titlesInSegementSlideSwitcherView,
//            !titles.isEmpty else {
//            return
//        }
        // titles.isEmptyがtureだったらreturnさせたいので、、、
        // 2重否定で、tureじゃない場合"じゃなかったら"returnさせる(trueだったらreturn)　// わかりづらい
        guard let titles = titlesInSegementSlideSwitcherView,
              !titles.isEmpty else {
            return
        }

        /// 始めから自分で設定？
        // Returns a sequence of pairs (n, x), where n represents a consecutive integer starting at zero and x represents an element of the sequence.
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            // falseだと、フレームが受信機の可視範囲を超えているサブビューはクリップされない // デフォルトの値は false
            button.clipsToBounds = false
            button.titleLabel?.font = innerConfig.normalTitleFont
            button.backgroundColor = .clear
            // ここでタイトルを伝える
            button.setTitle(title, for: .normal)
            // ここで順番を上手く伝える
            button.tag = index
            button.setTitleColor(innerConfig.normalTitleColor, for: .normal)
            // 【メモ】ここでボタンのタップ後の挙動を設定
            button.addTarget(self, action: #selector(didClickTitleButton), for: .touchUpInside)
            scrollView.addSubview(button)
            titleButtons.append(button)
        }

        // 【疑問メモ】indicatorViewはどこに表示するかの成約がまだ
        scrollView.addSubview(indicatorView)
        // サブレイヤーがレイヤーの境界にクリッピングされるかどうかを示すブール値
        indicatorView.layer.masksToBounds = true
        indicatorView.layer.cornerRadius = innerConfig.indicatorHeight/2
        indicatorView.backgroundColor = innerConfig.indicatorColor
    }

    private func reloadContents() {
        // .zeroだったらreturn
        guard scrollView.frame != .zero else {
            return
        }
        // .isEmptyがtureだったらreturn // self.bounds.width
        guard !titleButtons.isEmpty else {
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
            return
        }
//        scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)

        // titleButtonをframeのx座標として設定するのに必要
        var offsetX = innerConfig.horizontalMargin
        // 【疑問メモ】titleButton.frame = .zeroしていたのでここで設定してあげる必要がある？
        for titleButton in titleButtons {
            let buttonWidth: CGFloat
            buttonWidth = (bounds.width-innerConfig.horizontalMargin*2)/CGFloat(titleButtons.count) // CGFloat型だからそれで割る

            // 削除🔺
//            switch innerConfig.type {
//            case .tab:
//                buttonWidth = (bounds.width-innerConfig.horizontalMargin*2)/CGFloat(titleButtons.count)
//            case .segement:
//                let title = titleButton.title(for: .normal) ?? ""
//                let normalButtonWidth = title.boundingWidth(with: innerConfig.normalTitleFont)
//                let selectedButtonWidth = title.boundingWidth(with: innerConfig.selectedTitleFont)
//                buttonWidth = selectedButtonWidth > normalButtonWidth ? selectedButtonWidth : normalButtonWidth
//            }

            // 【疑問】self.bounds.heightではなく、scrollView.bounds.heightなのはsuperViewだから？
            titleButton.frame = CGRect(x: offsetX, y: 0, width: buttonWidth, height: scrollView.bounds.height)
            offsetX += buttonWidth

            // 削除🔺
//            switch innerConfig.type {
//            case .tab:
//                offsetX += buttonWidth
//            case .segement:
//                offsetX += buttonWidth+innerConfig.horizontalSpace
//            }
        }
        // 【メモ】ここじゃなくて、上の方に書いてもよさそう
        scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)

        // 削除🔺
//        switch innerConfig.type {
//        case .tab:
//            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
//        case .segement:
//            scrollView.contentSize = CGSize(width: offsetX-innerConfig.horizontalSpace+innerConfig.horizontalMargin, height: bounds.height)
//        }
    }

    // 【メモ】ボタンタップ後の動きを設定している(なんとanimationを使っていた！)
    private func updateSelectedButton(at index: Int, animated: Bool) {
        print(selectedIndex)
        print(defaultSelectedIndex)
        guard scrollView.frame != .zero else {
            return
        }
        guard index != selectedIndex else {
            return
        }
        let count = titleButtons.count
        if let selectedIndex = selectedIndex {
            guard selectedIndex >= 0, selectedIndex < count else {
                return
            }
            let selectedTitleButton = titleButtons[selectedIndex]
            selectedTitleButton.setTitleColor(innerConfig.normalTitleColor, for: .normal)
            selectedTitleButton.titleLabel?.font = innerConfig.normalTitleFont
        }
        guard index >= 0, index < count else {
            return
        }
        let titleButton = titleButtons[index]
        titleButton.setTitleColor(innerConfig.selectedTitleColor, for: .normal)
        titleButton.titleLabel?.font = innerConfig.selectedTitleFont
        if animated, indicatorView.frame != .zero {
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-self.innerConfig.indicatorWidth)/2, y: self.frame.height-self.innerConfig.indicatorHeight, width: self.innerConfig.indicatorWidth, height: self.innerConfig.indicatorHeight)
            }
        } else {
            indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-innerConfig.indicatorWidth)/2, y: frame.height-innerConfig.indicatorHeight, width: innerConfig.indicatorWidth, height: innerConfig.indicatorHeight)
        }

        // よくわかんない削除？
//        if case .segement = innerConfig.type {
//            var offsetX = titleButton.frame.origin.x-(scrollView.bounds.width-titleButton.bounds.width)/2
//            if offsetX < 0 {
//                offsetX = 0
//            } else if (offsetX+scrollView.bounds.width) > scrollView.contentSize.width {
//                offsetX = scrollView.contentSize.width-scrollView.bounds.width
//            }
//            if scrollView.contentSize.width > scrollView.bounds.width {
//                scrollView.setContentOffset(CGPoint(x: offsetX, y: scrollView.contentOffset.y), animated: animated)
//            }
//        }

        self.selectedIndex = index
    }

    @objc
    private func didClickTitleButton(_ button: UIButton) {
        selectItem(at: button.tag, animated: true)
    }

}

