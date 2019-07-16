//
//  Service.swift
//  UITabBerController
//
//  Created by home on 2019/07/16.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class Service: NSObject {
    func getTableItems(completionHandler: @escaping ([ListItem]) -> ()) {
        let configuration = URLSessionConfiguration.default
        
        if let url = URL(string: "http://localhost/test2.php") {
            WebApi ().getAddConfiguration(url: url, configuration: configuration, completionHandler: {(data, response, error) -> Void in
                if let data = data {
                    
                    do {
                        let decoder = JSONDecoder()
                        let items = try decoder.decode([ListItem].self, from: data)
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
