//
//  Section.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/13.
//

struct Section {
    let title: String
    let options: [SectionOptionType]
}

enum SectionOptionType {
    case staticCell(model: SectionOption) // イニシャライザ？
    case switchCell(model: SectionSwitchOption) // イニシャライザ?
    // 追加
    case testCell(model: SectionOption)
}
