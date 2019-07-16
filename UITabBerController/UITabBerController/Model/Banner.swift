//
//  Banner.swift
//  UITabBerController
//
//  Created by home on 2019/07/08.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class Banner: NSObject {
    var buttons: [UIButton] = []
    var offsetX: CGFloat = 0
    var timer: Timer!
    
    let firstButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220300.jpg"
    let secondButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220253.jpg"
    let thirdButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220248.jpg"
    
    func loadButtonImage(url: String, completionHandler: @escaping (_ image: UIImage) -> ()) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        if let url = URL(string: url) {
            WebApi().getAddConfiguration(url: url, configuration: configuration, completionHandler: {(data, response, error) -> Void in
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
}

