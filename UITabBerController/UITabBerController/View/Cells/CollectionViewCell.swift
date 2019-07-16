//
//  CollectionViewCell.swift
//  UITabBerController
//
//  Created by home on 2019/06/02.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpContents(image: UIImage, textName: String) {
        imageView.image = image
        label.text = textName
    }
}
