//
//  FirstViewController.swift
//  UITabBerController
//
//  Created by home on 2018/03/31.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var buttons: [UIButton] = []
    
    private var offsetX: CGFloat = 0
    private var timer: Timer!
    
    private let sectionName = [["Section1"], ["Section2"], ["Section3"]]
    private let data = [["item1", "item2", "item3"], ["item4", "item5", "item6"], ["item7", "item8", "item9"]]
    private let photo = [["photo1", "photo2", "photo3"], ["photo4", "photo5", "photo6"], ["photo7", "photo8", "photo9"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.scrollView.frame.height)
        
        self.scrollView.delegate = self
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.setUpAdButtons()
        
        // タイマーを作成
        self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showButtonImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    private func setUpAdButtons() {
        for i in 0 ..< 3 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            button.frame = CGRect(origin: CGPoint(x: self.view.frame.size.width * CGFloat(i), y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            button.tag += i
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(transitionDetail), for: UIControl.Event.touchUpInside)
            self.scrollView.addSubview(button)
            self.buttons.append(button)
        }
    }
    
    private func showButtonImages() {
        let urls = ["https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220300.jpg", "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220253.jpg", "https://cdn-ak.f.st-hatena.com/images/fotolife/h/hfoasi8fje3/20190608/20190608220248.jpg"]
        
        for i in 0 ..< urls.count {
            if let url = URL(string: urls[i]) {
                let configuration = URLSessionConfiguration.default
                configuration.requestCachePolicy = .returnCacheDataElseLoad
                let session = URLSession(configuration: configuration)
                let task = session.dataTask(with: url) { (data, response, error) in
                    session.invalidateAndCancel()
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        return
                    }
                    
                    if response.statusCode == 200 {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.buttons[i].setImage(image, for: .normal)
                        }
                    } else {
                        print(response.statusCode)
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc private func transitionDetail() {
        print("ボタンが押された")
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
        let cellImage = UIImage(named: photo[indexPath.section][indexPath.item])!
        let cellText = data[indexPath.section][indexPath.item]
        cell.setUpContents(image: cellImage,textName: cellText)
        
        return cell
    }
    
    // ヘッダーの設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
        let headerText = sectionName[indexPath.section][indexPath.item]
        collectionViewHeader.setUpContents(titleText: headerText)
        return collectionViewHeader
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


