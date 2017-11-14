//
//  ViewController.swift
//  PuPuLiu
//
//  Created by yihui on 2017/11/15.
//  Copyright © 2017年 yihui. All rights reserved.
//

import UIKit

// 注册ID
private let hContentCellID = "hContentCellID"

class ViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = HHWaterfallLayout()
        // 设置内边距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // 列边距
        layout.minimumInteritemSpacing = 10
        // 行边距
        layout.minimumLineSpacing = 10
        
        layout.dataSource = self
        // 创建coll
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        // 设置数据源代理
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加coll
        view.addSubview(collectionView)
        // 注册coll
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: hContentCellID)
        
    }

}

extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 99
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hContentCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
}


extension ViewController : HHWaterfallLayoutDataSource {
    
    func numberOfCols(_ waterfall: HHWaterfallLayout) -> Int {
        return 3
    }
    
    func waterfall(_ waterfall: HHWaterfallLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
}







































