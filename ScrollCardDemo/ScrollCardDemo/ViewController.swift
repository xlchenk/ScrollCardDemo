//
//  ViewController.swift
//  ScrollCardDemo
//
//  Created by 陈晓龙 on 2017/7/17.
//  Copyright © 2017年 陈晓龙. All rights reserved.
//

import UIKit
 let SCREEN_WIDTH = UIScreen.main.bounds.size.width
 let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
class ViewController: UIViewController {
    private var collectionView:UICollectionView?
    private var layout:CustomLayout?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setepUI()
    }

    func setepUI() {
        layout = CustomLayout()
        layout?.itemSize = CGSize(width: SCREEN_WIDTH-80, height: SCREEN_HEIGHT-64-120)
        
        let rect = CGRect(x: 0, y: 64, width:SCREEN_WIDTH , height: SCREEN_HEIGHT-64)
       collectionView = UICollectionView(frame: rect, collectionViewLayout: layout!)
       collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        collectionView?.register(CustomViewCell.self, forCellWithReuseIdentifier: "identifier")
        collectionView?.backgroundColor = UIColor.red
        
    }
   
}
// MARK: -- delegate and datasource
extension ViewController:
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! CustomViewCell
    cell.backgroundColor = UIColor.orange
    cell.lable?.text = "\(indexPath.row)/\(10)"
    return cell
    }
}

