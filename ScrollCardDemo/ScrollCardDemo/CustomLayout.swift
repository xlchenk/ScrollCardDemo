//
//  CustomLayout.swift
//  ScrollCardDemo
//
//  Created by 陈晓龙 on 2017/7/17.
//  Copyright © 2017年 陈晓龙. All rights reserved.
//
import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    private let ScaleFactor:CGFloat = 0.001//缩放因子
//MARK:--- 布局之前的准备工作 初始化  这个方法只会调用一次
    override func prepare() {
        scrollDirection = UICollectionViewScrollDirection.horizontal
         minimumLineSpacing = 20.0
        sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        super.prepare()
    }
    //（该方法默认返回false） 返回true  frame发生改变就重新布局  内部会重新调用prepare 和layoutAttributesForElementsInRect
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

//MARK:---用来计算出rect这个范围内所有cell的UICollectionViewLayoutAttributes，
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       //根据当前滚动进行对每个cell进行缩放
        //首先获取 当前rect范围内的 attributes对象
        let array = super.layoutAttributesForElements(in: rect)
        
        //计算缩放比  首先计算出整体中心点的X值 和每个cell的中心点X的值
        //用着两个x值的差值 ，计算出绝对值，
        //
        //colleciotnView中心点的值
        let centerX =  (collectionView?.contentOffset.x)! + (collectionView?.bounds.size.width)!/2
        //循环遍历每个attributes对象 对每个对象进行缩放
        for attr in array! {
            //计算每个对象cell中心点的X值
            let cell_centerX = attr.center.x
            
            //计算两个中心点的便宜（距离）
            //距离越大缩放比越小，距离小 缩放比越大，缩放比最大为1，即重合
            let distance = abs(cell_centerX-centerX)
            let scale:CGFloat = 1/(1+distance*ScaleFactor)
            attr.transform3D = CATransform3DMakeScale(1.0, scale, 1.0)
            
        }
       
     return array
    }
    
    /// <#Description#>
    ///
    /// - Parameter proposedContentOffset: 当手指滑动的时候 最终的停止的偏移量
    /// - Returns: 返回最后停止后的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let visibleX = proposedContentOffset.x
        let visibleY = proposedContentOffset.y
        let visibleW = collectionView?.bounds.size.width
        let visibleH = collectionView?.bounds.size.height
        //获取可视区域
        let targetRect = CGRect(x: visibleX, y: visibleY, width: visibleW!, height: visibleH!)
        
        //中心点的值
        let centerX = proposedContentOffset.x + (collectionView?.bounds.size.width)!/2
        
        //获取可视区域内的attributes对象
        let attrArr = super.layoutAttributesForElements(in: targetRect)!
        //如果第0个属性距离最小
        var min_attr = attrArr[0]
        for attributes in attrArr {
            if (abs(attributes.center.x-centerX) < abs(min_attr.center.x-centerX)) {
                min_attr = attributes
            }
        }
        //计算出距离中心点 最小的那个cell 和整体中心点的偏移
        let ofsetX = min_attr.center.x - centerX
        return CGPoint(x: proposedContentOffset.x+ofsetX, y: proposedContentOffset.y)
    }
    
}

