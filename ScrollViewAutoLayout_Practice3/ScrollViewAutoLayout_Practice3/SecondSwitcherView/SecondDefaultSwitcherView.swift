//
//  SecondSwitcherView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

public enum SwitcherType {
    case tab
    case segement
}

public protocol DefaultSwitcherViewDelegate: AnyObject {
    var titlesInSegementSlideSwitcherView: [String] { get }
}

public class SecondDefaultSwitcherView: UIView {

    public private(set) var scrollView = UIScrollView()
    private let indicatorView = UIView()
    private var titleButtons: [UIButton] = []
    private var innerConfig: SwitcherConfig = SwitcherConfig.shared

    /// you should call `reloadData()` after set this property.
    open var defaultSelectedIndex: Int?
    public private(set) var selectedIndex: Int?
    public weak var delegate: DefaultSwitcherViewDelegate?

    /// you must call `reloadData()` to make it work, after the assignment.
    public var config: SwitcherConfig = SwitcherConfig.shared

    // 【疑問】これがなくても表示はできる→このプロパティはSecondDefaultSwitcherViewの固有サイズを変更するためのもの
    // ビュー階層を見るとあってもなくても紫の警告が出る
    // Layout Issues: Vertical position is ambiguous for SegementSlideDefaultSwitcherView.
    // storyboardにscrollViewだけを表示する方法でやってみると何かわかりそう
    public override var intrinsicContentSize: CGSize {
        return scrollView.contentSize
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(scrollView)
        // これがなかったらview階層に表示されなかった？　→これをいれることでScrollViewについて成約が貼れるようになった
        scrollView.constraintToSuperview()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = .clear
        backgroundColor = .white
    }

    // サブクラスは、これをオーバーライドして、サブビューのより正確なレイアウトを行う。
    // オーバーライドするのは、サブビューの自動サイズ調整や制約ベースの動作が、希望する動作を提供しない場合に限る。
    public override func layoutSubviews() {
        super.layoutSubviews()
        reloadContents()
        updateSelectedIndex()
    }

    public func reloadData() {
        reloadSubViews()
        /// 削除⭕
//        reloadContents()
//        reloadDataWithSelectedIndex()
    }

    // 【メモ】これがないとButtonをタップして変化がない
    // 【疑問】どこで読んでいるのか→@objcでボタンから読んでいる // 2ドデマでは？
    //  2回目以降のupdateSeletctedButton()はselectItem()を設定しているButtonのAddTargetから
    public func selectItem(at index: Int, animated: Bool) {
        // 【疑問】ここのindexはどこから来たもの？
        // 恐らく、selectItemの引数から来たもの
        updateSelectedButton(at: index, animated: animated)
    }

}

extension SecondDefaultSwitcherView {

// 削除?
//    private func reloadDataWithSelectedIndex() {
//        guard let index = selectedIndex else {
//            return
//        }
//        selectedIndex = nil
//        updateSelectedButton(at: index, animated: false)
//    }

    private func updateSelectedIndex() {
        // nilだったとしても処理を終わらせない
        if let index = selectedIndex  {
            // nilじゃなかったら
            print(selectedIndex)
            updateSelectedButton(at: index, animated: false)
        } else if let index = defaultSelectedIndex {
            // selectedIndexがnilでdefaultSelectedIndexがnilじゃなかったら
            print(defaultSelectedIndex)
            // 一番最初はdefaultSelectedIndexが0でその0をindexにしているが、
            // 2回目からはselectedIndexにnilではなく0が入っているはずなので、
            // 上の処理が呼ばれ、selectedIndexがindexとなり引数として渡される仕組み、、ではないらしい
            updateSelectedButton(at: index, animated: false)
        }
    }

    private func reloadSubViews() {
        // 削除?🔺 // 何のためにしているのか意図がわからない。。。
//        for titleButton in titleButtons {
//            titleButton.removeFromSuperview()
//            titleButton.frame = .zero
//        }
//        titleButtons.removeAll()
//        indicatorView.removeFromSuperview()
//        indicatorView.frame = .zero
        innerConfig = config
        guard let titles = delegate?.titlesInSegementSlideSwitcherView,
            !titles.isEmpty else {
            return
        }
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.clipsToBounds = false
            button.titleLabel?.font = innerConfig.normalTitleFont
            button.backgroundColor = .clear
            button.setTitle(title, for: .normal)
            button.tag = index
            button.setTitleColor(innerConfig.normalTitleColor, for: .normal)
            // 【メモ】ここでボタンのタップ後の挙動を設定
            button.addTarget(self, action: #selector(didClickTitleButton), for: .touchUpInside)
            scrollView.addSubview(button)
            titleButtons.append(button)
        }
        scrollView.addSubview(indicatorView)
        indicatorView.layer.masksToBounds = true
        indicatorView.layer.cornerRadius = innerConfig.indicatorHeight/2
        indicatorView.backgroundColor = innerConfig.indicatorColor
    }

    private func reloadContents() {
        guard scrollView.frame != .zero else {
            return
        }
        print(bounds.width)
        print(bounds.height)
        print(self.bounds.width)
        print(self.bounds.height)
        print(self) // SecondDefaultSwitcherView
        guard !titleButtons.isEmpty else {
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
            return
        }
        var offsetX = innerConfig.horizontalMargin
        for titleButton in titleButtons {
            let buttonWidth: CGFloat
            switch innerConfig.type {
            case .tab:
                buttonWidth = (bounds.width-innerConfig.horizontalMargin*2)/CGFloat(titleButtons.count)
            case .segement:
                let title = titleButton.title(for: .normal) ?? ""
                let normalButtonWidth = title.boundingWidth(with: innerConfig.normalTitleFont)
                let selectedButtonWidth = title.boundingWidth(with: innerConfig.selectedTitleFont)
                buttonWidth = selectedButtonWidth > normalButtonWidth ? selectedButtonWidth : normalButtonWidth
            }
            titleButton.frame = CGRect(x: offsetX, y: 0, width: buttonWidth, height: scrollView.bounds.height)
            switch innerConfig.type {
            case .tab:
                offsetX += buttonWidth
            case .segement:
                offsetX += buttonWidth+innerConfig.horizontalSpace
            }
        }
        switch innerConfig.type {
        case .tab:
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
        case .segement:
            scrollView.contentSize = CGSize(width: offsetX-innerConfig.horizontalSpace+innerConfig.horizontalMargin, height: bounds.height)
        }
    }

    // 【メモ】ボタンタップ後の動きを設定している
    private func updateSelectedButton(at index: Int, animated: Bool) {
        print(selectedIndex)
        print(defaultSelectedIndex) // 常に0
        guard scrollView.frame != .zero else {
            return
        }
        // index == selectedIndexの場合returnさせる(何回も呼ぶし、今と同じなら下の処理をしなくていい)
        guard index != selectedIndex else {
            return
        }
        let count = titleButtons.count
        // selectedIndexがnilだからここは実行されない?
        // 【疑問】ここのif文がないと、、他のbuttonがselectedされているままになってしまうのはなぜ？
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
                self.indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-self.innerConfig.indicatorWidth)/2,
                                    y: self.frame.height-self.innerConfig.indicatorHeight,
                                    width: self.innerConfig.indicatorWidth,
                                    height: self.innerConfig.indicatorHeight)
            }
        } else {
            indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-innerConfig.indicatorWidth)/2,
                                         y: frame.height-innerConfig.indicatorHeight,
                                         width: innerConfig.indicatorWidth,
                                         height: innerConfig.indicatorHeight)
        }
        if case .segement = innerConfig.type {
            var offsetX = titleButton.frame.origin.x-(scrollView.bounds.width-titleButton.bounds.width)/2
            if offsetX < 0 {
                offsetX = 0
            } else if (offsetX+scrollView.bounds.width) > scrollView.contentSize.width {
                offsetX = scrollView.contentSize.width-scrollView.bounds.width
            }
            if scrollView.contentSize.width > scrollView.bounds.width {
                scrollView.setContentOffset(CGPoint(x: offsetX, y: scrollView.contentOffset.y), animated: animated)
            }
        }
        // ここで初めてselectedIndexがnilじゃなくなる
        // 【疑問】このindexはメソッドの引数から渡されたものなのか？
        self.selectedIndex = index
        print(selectedIndex)
    }

    @objc
    private func didClickTitleButton(_ button: UIButton) {
        // ここでindex: Intとしてのbutton.tagを渡しているけど、、なにかおかしな挙動している気がする
        selectItem(at: button.tag, animated: true)
    }

}
