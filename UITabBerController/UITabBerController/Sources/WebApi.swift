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
}
