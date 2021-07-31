//
//  MyDefaultSwitcherView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/31.
//

import UIKit

// カスタムViewなのでイニシャライザが必要？
class MyDefaultSwitcherView: UIView {

    var scrollView = UIScrollView()
    private let indicatorView = UIView()
    private var titleButtons: [UIButton] = []

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
//        reloadContents()
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

extension SecondDefaultSwitcherView {

    private func updateSelectedIndex() {
        if let index = selectedIndex  {
            updateSelectedButton(at: index, animated: false)
        } else if let index = defaultSelectedIndex {
            updateSelectedButton(at: index, animated: false)
        }
    }

    private func reloadSubViews() {
        for titleButton in titleButtons {
            titleButton.removeFromSuperview()
            titleButton.frame = .zero
        }
        titleButtons.removeAll()
        indicatorView.removeFromSuperview()
        indicatorView.frame = .zero
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
        self.selectedIndex = index
    }

    @objc
    private func didClickTitleButton(_ button: UIButton) {
        selectItem(at: button.tag, animated: true)
    }

}

