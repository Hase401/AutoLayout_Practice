//
//  TestXibTableViewCell.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/14.
//

import UIKit

class TestXibTableViewCell: UITableViewCell {

    static let identifier = "TestXibTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "TestXibTableViewCell", bundle: nil)
    }

    @IBOutlet private weak var iconContainer: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        iconContainer.clipsToBounds = true
        iconContainer.layer.cornerRadius = 8
        iconContainer.layer.masksToBounds = true
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        label.numberOfLines = 1
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconContainer.backgroundColor = nil
        iconImageView.image = nil
    }

    func configure(with model: SectionOption) {
        label.text = model.title
        iconContainer.backgroundColor = model.iconBackgroundColor
        iconImageView.image = model.icon
    }
    
}
