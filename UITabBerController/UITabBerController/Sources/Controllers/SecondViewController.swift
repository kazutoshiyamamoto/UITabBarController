//
//  SecondViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

struct Item: Codable {
    var title: String
}

class SecondViewController: UIViewController {
    // テーブルビューに表示するデータ
    let sectionTitle = ["Section1"]
    var items: [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setUpTableItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableItems() {
        self.getTableItems(completionHandler: { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    private func getTableItems(completionHandler: @escaping ([Item]) -> Void) {
        if let url = URL(string: "http://localhost/test2.php") {
            self.get(url: url, queryItems: nil, completionHandler: { data, response, error in
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
    
    private func get(url: URL, queryItems: [URLQueryItem]? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        //        var components = URLComponents(string: url)
        //        components?.queryItems = queryItems
        //        let url = components?.url
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
    
    //    func get(url urlString: String, queryItems: [URLQueryItem]? = nil) {
    //        var components = URLComponents(string: urlString)
    //        components?.queryItems = queryItems
    //        let url = components?.url
    //        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
    //            if let data = data {
    //
    //                do {
    //                    let decoder = JSONDecoder()
    //                    let title = try decoder.decode([Item].self, from: data)
    //                    print(title[0].title)
    //                } catch {
    //                    print("Serialize Error")
    //                }
    //            } else {
    //                print(error ?? "Error")
    //            }
    //        }
    //        task.resume()
    //    }
}

extension SecondViewController: UITableViewDelegate {
    // セル選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row].title)
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
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
