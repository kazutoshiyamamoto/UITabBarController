//
//  CollectionViewHeader.swift
//  UITabBerController
//
//  Created by home on 2019/06/08.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpContents(titleText: String) {
        titleLabel.text = titleText
    }
}
