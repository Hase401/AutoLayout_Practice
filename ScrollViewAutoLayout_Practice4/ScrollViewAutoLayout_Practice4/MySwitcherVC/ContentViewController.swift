//
//  ContentViewController.swift
//  ScrollViewAutoLayout_Practice4
//
//  Created by 長谷川孝太 on 2021/08/05.
//

import UIKit

final class ContentViewController: UIViewController, ContentViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var fruits: [String] = ["ばなな", "りんご", "みかん", "もも"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
    }

}

/// 【メモ】そもそもUIViewControllerを継承しているのではなくて、tableViewControllerを継承しているから何か普段と違う！！
extension ContentViewController: UITableViewDelegate {
}

extension ContentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row]
        cell.backgroundColor = .green
        return cell
    }
}