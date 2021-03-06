//
//  FirstViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

enum MenuCellType: Int {
    case First = 0
    case Second
    case Third
    
    enum FirstItems: Int {
        case First = 0
        case Second
        case Third
    }
    
    enum SecondItems: Int {
        case First = 0
        case Second
        case Third
    }
    
    enum ThirdItems: Int {
        case First = 0
        case Second
        case Third
    }
}

class FirstViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leftBannerButton: UIButton!
    @IBOutlet weak var centerBannerButton: UIButton!
    @IBOutlet weak var rightBannerButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionName = [["Section1"], ["Section2"], ["Section3"]]
    let data = [["item1", "item2", "item3"], ["item4", "item5", "item6"], ["item7", "item8", "item9"]]
    let photo = [["photo1", "photo2", "photo3"], ["photo4", "photo5", "photo6"], ["photo7", "photo8", "photo9"]]
    
    private var offsetX: CGFloat = 0
    private var timer: Timer!
    
    let firstButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220300.jpg"
    let secondButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220253.jpg"
    let thirdButtonImageUrl = "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220248.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpButtonImage()
        // タイマーを作成
        self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // タイマーを破棄
        if let workingTimer = self.timer {
            workingTimer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpButtonImage() {
        let imageDownloadApi = ImageDownloadApi()
        imageDownloadApi.loadButtonImage(url: self.firstButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.leftBannerButton.setImage(image, for: .normal)
        })
        
        imageDownloadApi.loadButtonImage(url: self.secondButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.centerBannerButton.setImage(image, for: .normal)
        })
        
        imageDownloadApi.loadButtonImage(url: self.thirdButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.rightBannerButton.setImage(image, for: .normal)
        })
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        print("ボタン1")
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        print("ボタン2")
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        print("ボタン3")
    }
    
    // offsetXの値を更新することページを移動
    @objc private func scrollPage() {
        // 画面の幅分offsetXを移動
        self.offsetX += self.view.frame.size.width
        // 3ページ目まで移動したら1ページ目まで戻る
        if self.offsetX < self.view.frame.size.width * 3 {
            UIView.animate(withDuration: 0.2) {
                self.scrollView.contentOffset.x = self.offsetX
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.offsetX = 0
                self.scrollView.contentOffset.x = self.offsetX
            }
        }
    }
}

extension FirstViewController: UICollectionViewDelegate {
    // セル選択時の処理
    // TODO:default消すとエラーになる現象の解消
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (MenuCellType.First.rawValue, MenuCellType.FirstItems.First.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.First.rawValue, MenuCellType.FirstItems.Second.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.First.rawValue, MenuCellType.FirstItems.Third.rawValue):
            print(self.data[indexPath.section][indexPath.row])
            
        case (MenuCellType.Second.rawValue, MenuCellType.SecondItems.First.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.Second.rawValue, MenuCellType.SecondItems.Second.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.Second.rawValue, MenuCellType.SecondItems.Third.rawValue):
            print(self.data[indexPath.section][indexPath.row])
            
        case (MenuCellType.Third.rawValue, MenuCellType.ThirdItems.First.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.Third.rawValue, MenuCellType.ThirdItems.Second.rawValue):
            print(self.data[indexPath.section][indexPath.row])
        case (MenuCellType.Third.rawValue, MenuCellType.ThirdItems.Third.rawValue):
            print(self.data[indexPath.section][indexPath.row])
            
        default:
            print("テスト")
        }
    }
}

extension FirstViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scrollViewのページ移動に合わせてpageControlの表示も移動
        self.pageControl.currentPage = Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        // offsetXの値を更新
        self.offsetX = self.scrollView.contentOffset.x
    }
}

extension FirstViewController:  UICollectionViewDelegateFlowLayout {    
    // ヘッダーのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50)
    }
}

extension FirstViewController: UICollectionViewDataSource {
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
        let cellImage = UIImage(named: self.photo[indexPath.section][indexPath.item])!
        let cellText = self.data[indexPath.section][indexPath.item]
        cell.setUpContents(image: cellImage,textName: cellText)
        
        return cell
    }
    
    // ヘッダーの設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
        let headerText = self.sectionName[indexPath.section][indexPath.item]
        collectionViewHeader.setUpContents(titleText: headerText)
        return collectionViewHeader
    }
}


