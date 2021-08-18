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
    // 【疑問】ここの仕組み(文法)は何か？
    case staticCell(model: SectionOption)
    case switchCell(model: SectionSwitchOption)
    // 追加  // viewControllerでのコードが長くなりがちなので設計が悪い気がする
    case testCell(model: SectionOption)
}
