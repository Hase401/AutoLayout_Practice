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

    // イニシャライザでUI部品(プロパティ)をView階層に追加
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator

        // 恐らくAutoLayoutなのにframeのように考えている気がする →　中心を揃える成約を使ったほうがいい
//        let containerSize = contentView.frame.size.height-12
//        let imageSize = containerSize/1.5
//        NSLayoutConstraint.activate([
//            // horizontal
//            iconContainer.widthAnchor.constraint(equalToConstant: containerSize),
//            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            iconContainer.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -15),
//            iconImageView.widthAnchor.constraint(equalToConstant: imageSize),
//            iconImageView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 5),
//            iconImageView.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: -5),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//            // vertical
//            iconContainer.heightAnchor.constraint(equalToConstant: containerSize),
//            iconContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            iconContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
//            iconImageView.heightAnchor.constraint(equalToConstant: imageSize),
//            iconImageView.topAnchor.constraint(equalTo: iconContainer.topAnchor, constant: 5),
//            iconImageView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -5),
//            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
    }

    required init?(coder: NSCoder) {
        fatalError() // 使わないのでfatalError()しておく
    }


    // 1つのcellごとに呼ばれている
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

