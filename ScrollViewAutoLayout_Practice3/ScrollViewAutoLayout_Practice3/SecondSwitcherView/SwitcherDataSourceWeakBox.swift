//
//  SecondSwitcherDataSourceWeakBox.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

final public class SwitcherDataSourceWeakBox {

    public private(set) weak var unbox: SwitcherDataSource?
    public init(_ value: SwitcherDataSource?) {
        unbox = value
    }

}
