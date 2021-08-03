//
//  SwitcherDelegate.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/03.
//

import UIKit

public protocol SwitcherDataSource: AnyObject {
    var height: CGFloat { get }
    var titles: [String] { get }
}

public protocol SwitcherDelegate: UIView {
    var ssDataSource: SwitcherDataSource? { get set }
    var ssDefaultSelectedIndex: Int? { get set }
    var ssSelectedIndex: Int? { get }
    // 削除⭕
//    var ssScrollView: UIScrollView { get }

    func reloadData()

    // 削除⭕
//    func selectItem(at index: Int, animated: Bool)
}

internal final class SegementSlideSwitcherEmptyView: UIView, SwitcherDelegate {
    weak var ssDataSource: SwitcherDataSource? = nil
    var ssDefaultSelectedIndex: Int? = nil
    var ssSelectedIndex: Int? = nil
    // 削除⭕
//    var ssScrollView: UIScrollView = UIScrollView()

    func reloadData() {

    }

    // 削除⭕
//    func selectItem(at index: Int, animated: Bool) {
//
//    }
}
