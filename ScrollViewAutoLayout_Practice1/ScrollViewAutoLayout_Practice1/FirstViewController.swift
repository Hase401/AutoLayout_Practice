//
//  ScrollViewController.swift
//  ScrollViewAutoLayout_Practice1
//
//  Created by 長谷川孝太 on 2021/07/15.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareForStackView()
    }

    // stackViewの中身よりも、contentのsizeが大きくならないと駄目
    private func prepareForStackView() {
        // stackViewでは、heightのみ明確に決まっている
        let stackedViewSize = stackView.bounds.height

        for _ in 1..<5 {
            let stackedView = UIView()
            stackedView.backgroundColor = .orange
            stackedView.widthAnchor.constraint(equalToConstant: stackedViewSize).isActive = true
            stackedView.heightAnchor.constraint(equalToConstant: stackedViewSize).isActive = true
            // これは何？
            stackView.addArrangedSubview(stackedView)
        }
    }

}
