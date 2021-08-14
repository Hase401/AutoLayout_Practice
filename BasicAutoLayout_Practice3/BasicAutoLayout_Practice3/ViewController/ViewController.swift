//
//  ViewController.swift
//  BasicAutoLayout_Practice3
//
//  Created by 長谷川孝太 on 2021/08/13.
//

import UIKit

final class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        // nib()にしないとエラーになる
        table.register(TestXibTableViewCell.nib(), forCellReuseIdentifier: TestXibTableViewCell.identifier)
        return table
    }()

    private var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupModels()
    }

}

extension ViewController {

    private func setupTableView() {
        self.title = "記録する"
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self


        // 【パターン①】
//        tableView.frame = self.view.bounds

        // 【パターン②】
        // translatesAutoresizingMaskIntoConstraintsがfalseじゃないと動かない
        NSLayoutConstraint.activate([
            // horizontal
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            // vertical
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // 【パターン③】
//        let groups = [
//            // horizontal
//            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            // vertical
//            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ]
//        groups.map { $0.isActive = true }
        
    }

    private func setupModels() {
        self.models.append(Section(title: "記録する", options: [
            // 【疑問】enumの使い方はswitchだけではない
            .switchCell(model: SectionSwitchOption(title: "Wifi",
                                                   icon: UIImage(systemName: "house"),
                                                   iconBackgroundColor: .systemPink, hander: {

                                                   }, isOn: true))
        ]))
        self.models.append(Section(title: "2021", options: [
            .staticCell(model: SectionOption(title: "Wifi",
                                             icon: UIImage(systemName: "house"),
                                             iconBackgroundColor: .systemPink) {

            }),
            .staticCell(model: SectionOption(title: "Bluetooth",
                                             icon: UIImage(systemName: "bluetooth"),
                                             iconBackgroundColor: .link) {

            }),
            .staticCell(model: SectionOption(title: "Airplane Mode",
                                             icon: UIImage(systemName: "airplane"),
                                             iconBackgroundColor: .systemGreen) {

            }),
            .staticCell(model: SectionOption(title: "iCloud",
                                             icon: UIImage(systemName: "icloud"),
                                             iconBackgroundColor: .systemOrange) {

            })
        ]))
        self.models.append(Section(title: "2021/8", options: [
            .testCell(model: SectionOption(title: "Wifi",
                                             icon: UIImage(systemName: "house"),
                                             iconBackgroundColor: .systemPink) {

            }),
            .testCell(model: SectionOption(title: "Bluetooth",
                                             icon: UIImage(systemName: "bluetooth"),
                                             iconBackgroundColor: .link) {

            }),
            .testCell(model: SectionOption(title: "Airplane Mode",
                                             icon: UIImage(systemName: "airplane"),
                                             iconBackgroundColor: .systemGreen) {

            }),
            .testCell(model: SectionOption(title: "iCloud",
                                             icon: UIImage(systemName: "icloud"),
                                             iconBackgroundColor: .systemOrange) {

            })
        ]))
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        // 【疑問】このlet modelでやっている仕組みは何か？
        case .staticCell(let model):
            model.hander()
        case .switchCell(let model):
            model.hander()
        case .testCell(let model):
            model.hander()
        }
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]

        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier,
                                                           for: indexPath) as? SettingTableViewCell else {
                fatalError("SettingTableViewCellが返ってきてません")
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier,
                                                           for: indexPath) as? SwitchTableViewCell else {
                fatalError("SettingTableViewCellが返ってきてません")
            }
            cell.configure(with: model)
            return cell
        case .testCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TestXibTableViewCell.identifier,
                                                           for: indexPath) as? TestXibTableViewCell else {
                fatalError("TestXibTableViewCellが返ってきてません")
            }
            cell.configure(with: model)
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
}


