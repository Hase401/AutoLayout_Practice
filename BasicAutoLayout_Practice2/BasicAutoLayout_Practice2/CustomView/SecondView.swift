//
//  SecondView.swift
//  BasicAutoLayout_Practice2
//
//  Created by 長谷川孝太 on 2021/07/18.
//

import UIKit

/// AutoresizingMask None Version
class SecondView: UIView {

    // 【疑問】セットで必要？
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        nibInit()
    }

    private func nibInit() {
        let nib = UINib(nibName: "SecondView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
//        view.frame.size.width = CGFloat(384)
//        view.frame.size.height = CGFloat(240)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }

}
