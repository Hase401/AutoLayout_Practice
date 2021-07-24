//
//  FirstSwitcherView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/24.
//

import UIKit

public class FirstSwitcherView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibInit()
    }

    private func nibInit() {
        let nib = UINib(nibName: "FirstSwitcherView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

}
