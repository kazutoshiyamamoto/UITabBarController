//
//  CustomView.swift
//  UITabBerController
//
//  Created by home on 2019/07/24.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var bannerButton: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib() {
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func bannerTapped(_ sender: Any) {
        print("テスト")
    }
}
