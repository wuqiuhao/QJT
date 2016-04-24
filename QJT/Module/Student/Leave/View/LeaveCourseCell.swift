//
//  LeaveCourseCell.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCourseCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var courselayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (UIScreen.mainScreen().bounds.width - 20 ) / 5
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:  0, right: 0)
        layout.scrollDirection = .Horizontal
        return layout
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.setCollectionViewLayout(courselayout, animated: true)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension LeaveCourseCell: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            //return CGSize(width: 24, height: 24)
            return CGSize(width: 19.0, height: 19.0)
        case 1,2,3,4,5,7,8,9:
            print(UIScreen.mainScreen().bounds.width)
            print((UIScreen.mainScreen().bounds.width - 19 ) / 5.0)
            //return CGSize(width: CGFloat((UIScreen.mainScreen().bounds.width - 24 ) / 5), height: 24)
            //return CGSize(width: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0, height: 19.0)
            return CGSize(width: 19.0, height: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0)
        case 6,12,18,24,30,36,42,48,54,60:
            //return CGSize(width: 24, height: CGFloat((UIScreen.mainScreen().bounds.width - 24 ) / 5))
            //return CGSize(width: 19.0, height: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0)
            return CGSize(width: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0, height: 19.0)
        default:
            //return CGSize(width: CGFloat((UIScreen.mainScreen().bounds.width - 24 ) / 5), height: CGFloat((UIScreen.mainScreen().bounds.width - 24 ) / 5))
            return CGSize(width: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0, height: (UIScreen.mainScreen().bounds.width - 19 ) / 5.0)
        }
        
    }
}

// MARK: - UICollectionViewDataSource
extension LeaveCourseCell: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LeaveCourseCollectionCell", forIndexPath: indexPath) as! LeaveCourseCollectionCell
        cell.numLbl.text = "\(indexPath.item)"

        
        return cell
    }
}
