//
//  FirstViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionName = [["Section1"], ["Section2"], ["Section3"]]
    let data = [["item1", "item2", "item3"], ["item4", "item5", "item6"], ["item7", "item8", "item9"]]
    let photo = [["photo1", "photo2", "photo3"], ["photo4", "photo5", "photo6"], ["photo7", "photo8", "photo9"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    // セル選択時の処理
    // TODO:default消すとエラーになる現象の解消
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (CollectionViewCellType.First.rawValue, CollectionViewCellType.FirstItems.First.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.First.rawValue, CollectionViewCellType.FirstItems.Second.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.First.rawValue, CollectionViewCellType.FirstItems.Third.rawValue):
            print(data[indexPath.section][indexPath.row])
            
        case (CollectionViewCellType.Second.rawValue, CollectionViewCellType.SecondItems.First.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.Second.rawValue, CollectionViewCellType.SecondItems.Second.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.Second.rawValue, CollectionViewCellType.SecondItems.Third.rawValue):
            print(data[indexPath.section][indexPath.row])
            
        case (CollectionViewCellType.Third.rawValue, CollectionViewCellType.ThirdItems.First.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.Third.rawValue, CollectionViewCellType.ThirdItems.Second.rawValue):
            print(data[indexPath.section][indexPath.row])
        case (CollectionViewCellType.Third.rawValue, CollectionViewCellType.ThirdItems.Third.rawValue):
            print(data[indexPath.section][indexPath.row])

        default:
            print("テスト")
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    // セルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    // ヘッダーの数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionName.count
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let cellImage = UIImage(named: photo[indexPath.section][indexPath.item])!
        let cellText = data[indexPath.section][indexPath.item]
        cell.setUpContents(image: cellImage,textName: cellText)
        
        return cell
    }
    
    // ヘッダーの設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
        let headerText = sectionName[indexPath.section][indexPath.item]
        collectionViewHeader.setUpContents(titleText: headerText)
        return collectionViewHeader
    }
}

extension CollectionViewController:  UICollectionViewDelegateFlowLayout {
    // セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    // セルの余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // ヘッダーのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50)
    }
}


