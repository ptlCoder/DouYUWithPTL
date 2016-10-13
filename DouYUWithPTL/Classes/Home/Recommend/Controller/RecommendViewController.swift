//
//  RecommendViewController.swift
//  DYZB
//
//  Created by pengtanglong on 16/9/18.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"



class RecommendViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var recommendVM : HomeViewModel = HomeViewModel()
    
// MARK: 懒加载 滚动视图
    fileprivate lazy var cycleView : HomeCycleView = {
        let cycleView = HomeCycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : HomeGameView = {
        let gameView = HomeGameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.red
        return gameView
    }()
    
       // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 发送网络请求
        loadData()
        
        // 注册cell
        registerCell()

        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 20, right: 0);
        
        // 添加头视图
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
    }
    
}


// MARK: - 注册cell
extension RecommendViewController {

    @objc fileprivate func registerCell() {
        collectionView.register(UINib(nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "PrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
    }
}


// MARK: - 发送网络请求
extension RecommendViewController {
    
    @objc fileprivate func loadData() {
        
        recommendVM.requestData { 
            // 刷新
            self.collectionView.reloadData()
            
            // 传值 游戏视图数据
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        
        // MARK: 滚动视图数据
        recommendVM.requestCycleData {
            // 传值 滚动视图数据
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 设置UI界面内容
extension RecommendViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let model = group.anchors[indexPath.item]
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCell
            cell.model = model
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCell
            cell.model = model
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
    
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HeaderView
        
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
}

extension RecommendViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(#function)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: kScreenW, height: kHeaderViewH)
    }

}

