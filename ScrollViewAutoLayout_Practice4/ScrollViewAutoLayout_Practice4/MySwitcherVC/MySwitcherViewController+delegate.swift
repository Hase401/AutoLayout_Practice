//
//  MySwitcherViewController+delegate.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/05.
//

// contentViewのスクロール時に呼ばれるかな？
extension MySwitcherViewController: SegementSlideContentDelegate {

    var segementSlideContentScrollViewCount: Int {
//        print("titleMySwitcherView", titleMySwitcherView)
        return titleMySwitcherView?.count ?? 0 // 初期値はnilなのでその可能性がある
    }

    // segementSlideContentViewControllerメソッドでContentVC(ContentViewDelegate?)を返している
    func segementSlideContentScrollView(at index: Int) -> ContentViewDelegate? {
//        let a = segementSlideContentViewController(at: index)
//        print("a:", a) // Optinal(ContentViewController)
        return segementSlideContentViewController(at: index) // ContentViewControllerを返す
    }

}

// switcherViewのタbuttonタップ時に呼ばれるdelegateメソッドかな？
extension MySwitcherViewController: SegementSlideDefaultSwitcherViewDelegate {

    // 【重要メモ】switcherのbuttonをタップすると、contentViewが表示される機能をまず実現してから逆のdelegate(contentViewのdelegate)もやる
    public func segementSwitcherView(_ segementSlideSwitcherView: MySwitcherView, didSelectAtIndex index: Int, animated: Bool) {
        if mySwitcherContentView.selectedIndex != index {
            mySwitcherContentView.selectItem(at: index, animated: animated)
        }
    }

}
