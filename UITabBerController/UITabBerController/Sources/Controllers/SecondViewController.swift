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
        WebAPI().getTableItems(completionHandler: { (items) in
            self.secondViewModel.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
//    private func get(url: URL, queryItems: [URLQueryItem]? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        //        var components = URLComponents(string: url)
//        //        components?.queryItems = queryItems
//        //        let url = components?.url
//        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
//    }
    
    
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
        print(self.secondViewModel.items[indexPath.row].title)
    }
}
