//
//  GamesViewController.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

private let gamesCellID = "gamesCellID"
private let headerViewID = "headerViewID"

private let kItemMargin : CGFloat = 20
private let gamesItemW = (kScreenW - 2 * kItemMargin) / 3
private let gamesItemH : CGFloat = 113
private let kHeaderViewH : CGFloat = 40
private let kGameViewH : CGFloat = 90

class GamesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    fileprivate lazy var gameView : GameTopView = {
        let gameView = GameTopView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.orange
        return gameView
    }()
    
    // MARK: 懒加载ViewModel
    fileprivate lazy var gamesVM : GamesViewModel = GamesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 请求数据
        loadData()
        // 添加游戏视图
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top:kGameViewH, left: 0, bottom: 20, right: 0);
        // 注册
        collectionView.register(UINib(nibName: "GamesCell", bundle: nil), forCellWithReuseIdentifier: gamesCellID)
        collectionView.register(UINib(nibName: "GamesHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        
    }
    
}

extension GamesViewController {
    
    fileprivate func loadData(){
    
        gamesVM.requestGamesData {
            // 刷新
            self.collectionView.reloadData()
        }
    }
}

extension GamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gamesVM.gamesModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gamesCellID, for: indexPath) as! GamesCell
        let gameModel = gamesVM.gamesModels[indexPath.item]
        cell.gamesModel = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as! GamesHeaderView
        return headView
    }
}

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(#function)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: gamesItemW, height: gamesItemH)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: kScreenW, height: kHeaderViewH)
    }
    
}


