//
//  PlayViewController.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kPlayItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kPlayItemH = kPlayItemW * 3 / 4

fileprivate let kPlayCellID = "kPlayCellID"

class PlayViewController: UIViewController {

    fileprivate lazy var playVM : PlayViewModel = PlayViewModel()
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 发送网络请求
        loadData()
        
        // 注册cell
        registerCell()

    }
}


// MARK: - 注册cell
extension PlayViewController {
    
    @objc fileprivate func registerCell() {
        
        collectionView.register(UINib(nibName: "PlayCell", bundle: nil), forCellWithReuseIdentifier: kPlayCellID)
    }
}


// MARK: - 发送网络请求
extension PlayViewController {
    
    @objc fileprivate func loadData() {
        
        playVM.requestPlayData {
            self.collectionView.reloadData()
        }
        
    }
}

extension PlayViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return playVM.palyModel.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPlayCellID, for: indexPath) as! PlayCell
        cell.playModel = playVM.palyModel[indexPath.item]
        return cell
    }

}

extension PlayViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: kPlayItemW, height: kPlayItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
    }
    
}

