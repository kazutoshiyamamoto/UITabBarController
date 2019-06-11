//
//  SecondViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

// テーブルビューに表示するデータ
let sectionTitle = ["Section1"]
let section0 = ["item1", "item2", "item3", "item4"]

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SecondViewController: UITableViewDelegate {
    // セル選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(section0[indexPath.row])
    }
}

extension SecondViewController: UITableViewDataSource {
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // 各セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // セル設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = section0[indexPath.row]
        return cell
    }
    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section0.count
    }
}
