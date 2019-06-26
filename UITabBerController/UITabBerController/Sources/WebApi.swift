//
//  APIClient.swift
//  UITabBerController
//
//  Created by home on 2019/06/25.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import Foundation
import UIKit

class WebApi {
    func getAddConfiguration(url: URL, configuration: URLSessionConfiguration, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: configuration)
        session.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
    func loadButtonImage(url: String, completionHandler: @escaping (_ image: UIImage) -> ()) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        if let url = URL(string: url) {
            self.getAddConfiguration(url: url, configuration: configuration, completionHandler: {(data, response, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)!
                        completionHandler(image)
                    }
                } else {
                    print(response.statusCode)
                }
            }
            )}
    }
    
    func getTableItems(completionHandler: @escaping ([Item]) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        if let url = URL(string: "http://localhost/test2.php") {
            self.getAddConfiguration(url: url, configuration: configuration, completionHandler: {(data, response, error) -> Void in
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
