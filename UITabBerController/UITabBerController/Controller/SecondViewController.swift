//
//  SecondViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    // テーブルビューに表示するデータ
    private var items: [ListItem] = []
    
    private var searchController = UISearchController()
    private var searchResults: [ListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.setUpTableItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableItems() {
        Service().getTableItems(completionHandler: { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension SecondViewController: UITableViewDelegate {
    // セル選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.items[indexPath.row].title)
    }
}

extension SecondViewController: UITableViewDataSource {
    // セル設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if self.searchController.isActive {
            cell.textLabel?.text = self.searchResults[indexPath.row].title
        } else {
            cell.textLabel?.text = items[indexPath.row].title
        }
        return cell
    }
    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return self.searchResults.count
        } else {
            return self.items.count
        }
    }
}

extension SecondViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = self.searchController.searchBar.text else {
            return
        }
        self.searchResults = self.items.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        self.tableView.reloadData()
    }
}
