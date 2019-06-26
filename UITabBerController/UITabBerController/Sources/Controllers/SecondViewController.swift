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
    
    private let secondViewModel = SecondViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = secondViewModel
        
        self.setUpTableItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableItems() {
        WebApi().getTableItems(completionHandler: { (items) in
            self.secondViewModel.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension SecondViewController: UITableViewDelegate {
    // セル選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.secondViewModel.items[indexPath.row].title)
    }
}
