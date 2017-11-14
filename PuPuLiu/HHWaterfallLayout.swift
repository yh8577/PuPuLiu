//
//  HHWaterfallLayout.swift
//  PuPuLiu
//
//  Created by yihui on 2017/11/15.
//  Copyright © 2017年 yihui. All rights reserved.
//

import UIKit

protocol HHWaterfallLayoutDataSource : class {
    func numberOfCols(_ waterfall : HHWaterfallLayout) -> Int
    func waterfall(_ waterfall : HHWaterfallLayout, item : Int) -> CGFloat
}

class HHWaterfallLayout: UICollectionViewFlowLayout {

    weak var dataSource : HHWaterfallLayoutDataSource?
    
    // 存储UICollectionViewLayoutAttributes的数组
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols : Int = {
        return self.dataSource?.numberOfCols(self) ?? 2
    }()
    fileprivate lazy var totalHetghts : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}


// MARK: - 准备布局
extension HHWaterfallLayout {
    
    override func prepare() {
        super.prepare()
 
        // 1.获取cell个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 2.给每个 coll 创建一个 -> UICollectionViewLayoutAttributes
        let cellW : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        for i in 0..<itemCount {
            // 1.根据i创建indexPath
            let indexPath = IndexPath(item: i, section: 0)
            
            // 2.根据indexPath创建对应的UICollectionViewLayoutAttributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 3.设置attr中的frame
            guard let cellH : CGFloat = self.dataSource?.waterfall(self, item: i) else {
                fatalError("请实现对应的数据源ff,并放回cell高度")
            }
            // 拿到数组中最小的值
            let minH = totalHetghts.min()!
            // 通过minH拿到index
            let minIndex = totalHetghts.index(of: minH)!
            let cellX : CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY : CGFloat = minH + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            
            // 4.保存attr
            cellAttrs.append(attr)
            
            // 5.添加当前的高度
            totalHetghts[minIndex] = minH + minimumLineSpacing + cellH
        }
        
    }
}

// MARK: - 返回准备好的布局
extension HHWaterfallLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
}

// MARK: - 设置contentSize
extension HHWaterfallLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHetghts.max()! + sectionInset.bottom)
    }
}
