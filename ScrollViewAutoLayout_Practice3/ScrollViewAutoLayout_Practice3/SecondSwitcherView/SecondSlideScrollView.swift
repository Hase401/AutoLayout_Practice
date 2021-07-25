//
//  SecondSlideScrollView.swift
//  ScrollViewAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/07/25.
//

import UIKit

public class SecondSlideScrollView: UIScrollView, UIGestureRecognizerDelegate {

    private var otherGestureRecognizers: [UIGestureRecognizer]?

    internal init(otherGestureRecognizers: [UIGestureRecognizer]? = nil) {
        self.otherGestureRecognizers = otherGestureRecognizers
        super.init(frame: .zero)
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let otherGestureRecognizers = otherGestureRecognizers, otherGestureRecognizers.contains(otherGestureRecognizer) {
            return false
        }
        return true
    }

}
