//
//  SettingTableViewCell.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/13.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"

    private let iconContainer: UIView =  {
        let view = UIView()
        view.clipsToBounds = true // subviewがsuperviewのboundsを超えない
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    // UI部品(プロパティ)をView階層に追加
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError() // 使わないのでfatalError()しておく
    }

    // 【疑問】レイアウトの前の何が終わるとシステムで呼ばれる？　// 成約が終わる→レイアウトの順番じゃなかったけ？
    override func layoutSubviews() {
        super.layoutSubviews()

        let size: CGFloat = contentView.frame.size.height-12
        iconContainer.frame = CGRect(x: 15,
                                     y: 12/2,
                                     width: size,
                                     height: size)
        let imageSize: CGFloat  = size/1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2,
                                     y: (size-imageSize)/2,
                                     width: imageSize,
                                     height: imageSize)
        label.frame = CGRect(x: 15+15+iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width-15-15-iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
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

