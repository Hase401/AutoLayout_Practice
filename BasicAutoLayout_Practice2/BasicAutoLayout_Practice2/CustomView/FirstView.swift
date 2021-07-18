//
//  UserInfoView.swift
//  BasicAutoLayout_Practice2
//
//  Created by 長谷川孝太 on 2021/07/17.
//

import UIKit

class FirstView: UIView {

    @IBOutlet private weak var sampleButton: UIButton!
    @IBOutlet private weak var sampleLabel: UILabel!

    // 【疑問】セットで必要？
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        nibInit()
    }

    private func nibInit() {
        let nib = UINib(nibName: "FirstView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
