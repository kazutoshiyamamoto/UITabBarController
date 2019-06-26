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
    
    private let firstViewModel = FirstViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.scrollView.frame.height)
        
        self.scrollView.delegate = self
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = firstViewModel
        
        self.setUpButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpButtonImage()
        
        // タイマーを作成
        self.firstViewModel.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // タイマーを破棄
        if let workingTimer = self.firstViewModel.timer {
            workingTimer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpButtons() {
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
    
    private func setUpButtonImage() {
        let webApi = WebAPI()
        webApi.loadButtonImage(url: self.firstViewModel.firstButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.buttons[0].setImage(image, for: .normal)
        })
        
        webApi.loadButtonImage(url: self.firstViewModel.secondButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.buttons[1].setImage(image, for: .normal)
        })
        
        webApi.loadButtonImage(url: self.firstViewModel.thirdButtonImageUrl, completionHandler: { (image: UIImage) -> Void in
            self.buttons[2].setImage(image, for: .normal)
        })
    }
    
    @objc private func transitionDetail(_ sender: UIButton) {
        enum ButtonTag: Int {
            case first = 0
            case second
            case third
        }
        
        if let buttonTag = ButtonTag(rawValue: sender.tag) {
            switch buttonTag {
            case .first:
                print("ボタン1")
            case .second:
                print("ボタン2")
            case .third:
                print("ボタン3")
            }
        }
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
        case (FirstViewCellType.First.rawValue, FirstViewCellType.FirstItems.First.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.First.rawValue, FirstViewCellType.FirstItems.Second.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.First.rawValue, FirstViewCellType.FirstItems.Third.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
            
        case (FirstViewCellType.Second.rawValue, FirstViewCellType.SecondItems.First.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.Second.rawValue, FirstViewCellType.SecondItems.Second.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.Second.rawValue, FirstViewCellType.SecondItems.Third.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
            
        case (FirstViewCellType.Third.rawValue, FirstViewCellType.ThirdItems.First.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.Third.rawValue, FirstViewCellType.ThirdItems.Second.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
        case (FirstViewCellType.Third.rawValue, FirstViewCellType.ThirdItems.Third.rawValue):
            print(self.firstViewModel.data[indexPath.section][indexPath.row])
            
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


