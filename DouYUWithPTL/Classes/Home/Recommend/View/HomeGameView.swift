//
//  HomeGameView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

private let collectionViewGameID = "collectionViewGameID"
/// 游戏item的宽度
private let collectionViewGameItemW = 80
/// 游戏item的高度
private let collectionViewGameItemH = 90


class HomeGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = [.init(rawValue: 0)]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: collectionViewGameID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    var groups : [AnchorGroup]? {
        didSet {
            // 移除前面两组
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 刷新
            collectionView.reloadData()
        }
    }

    class func gameView() -> HomeGameView {
        
        return Bundle.main.loadNibNamed("HomeGameView", owner: nil, options: nil)?.first as! HomeGameView
    }
}


// MARK:- 设置UI界面内容
extension HomeGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewGameID, for: indexPath) as! CollectionViewGameCell
        
        let gameMoel = groups?[indexPath.item]
        
        cell.groups = gameMoel
        
        return cell
    }
    
}

extension HomeGameView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewGameItemW, height: collectionViewGameItemH)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}

