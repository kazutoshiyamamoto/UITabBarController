//
//  SecondViewModel.swift
//  UITabBerController
//
//  Created by home on 2019/06/26.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

struct Item: Codable {
    var title: String
}

class List: NSObject {
    // テーブルビューに表示するデータ
    let sectionTitle = ["Section1"]
    var items: [Item] = []
    
    func getTableItems(completionHandler: @escaping ([Item]) -> ()) {
        let configuration = URLSessionConfiguration.default
        
        if let url = URL(string: "http://localhost/test2.php") {
            WebApi ().getAddConfiguration(url: url, configuration: configuration, completionHandler: {(data, response, error) -> Void in
                if let data = data {
                    
                    do {
                        let decoder = JSONDecoder()
                        let items = try decoder.decode([Item].self, from: data)
                        completionHandler(items)
                    } catch {
                        print("Serialize Error")
                    }
                } else {
                    print(error ?? "Error")
                }
            })
        }
    }
}

extension List: UITableViewDataSource {
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
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
