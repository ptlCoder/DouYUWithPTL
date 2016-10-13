//
//  AmuseViewController.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

// 顶部view的高度
private let TopViewHeight: CGFloat = 220
private let kItemMargin : CGFloat = 10
private let kPlayItemW = (kScreenW - 3 * kItemMargin) / 2
private let kPlayItemH = kPlayItemW * 3 / 4
private let kSectionHeaderViewH : CGFloat = 50

private let kAmuseCellID = "kAmuseCellID"
private let kSectionHeaderViewID = "kSectionHeaderViewID"

class AmuseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 懒加载
    fileprivate lazy var amuseTopView: AmuseTopView = {
    
        let amuseTopView = AmuseTopView.amuseTopView()
        amuseTopView.frame = CGRect(x: 0, y: -TopViewHeight, width: kScreenW, height: TopViewHeight)
        return amuseTopView
    }()
    
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载数据
        loadData()
        
        // 添加到collectionView
        collectionView.addSubview(amuseTopView)
        collectionView.contentInset = UIEdgeInsetsMake(TopViewHeight, 0, 0, 0)
        // 注册cell
        registerCell()
        
        // 添加AumsePageView通知
        NotificationCenter.default.addObserver(self, selector:#selector(aumsePageViewButtonClickNotification(notification:)),name: NSNotification.Name(rawValue: kAumsePageViewButtonClickNotification), object: nil)
        
    }
    
    // MARK: 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: 注册
extension AmuseViewController {
    @objc fileprivate func registerCell() {
        collectionView.register(UINib(nibName: "PlayCell", bundle: nil), forCellWithReuseIdentifier: kAmuseCellID)
        
        collectionView.register(UINib(nibName: "AmuseSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewID)
    }
}
// MARK: 加载数据
extension AmuseViewController {

    @objc fileprivate func loadData() {
        amuseVM.requestTopViewData {
            
            self.collectionView.reloadData()
            // 传值
            self.amuseTopView.amuseTopModels = self.amuseVM.amuseModels
        }
        
    }
}

// MARK:- 设置UI界面内容
extension AmuseViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return amuseVM.amuseModels.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let models = amuseVM.amuseModels[section]
        return models.room_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseCellID, for: indexPath) as! PlayCell
        
        let models = amuseVM.amuseModels[indexPath.section]
        let playModel = models.room_list?[indexPath.item]
        cell.playModel = PlayModel(dict:playModel!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderViewID, for: indexPath) as! AmuseSectionView
        let models = amuseVM.amuseModels[indexPath.section]
        headerView.titleLabel.text = models.tag_name
        if indexPath.section == 0 {
            headerView.iconImageView.image = UIImage(named: "home_header_hot")
        }else
        {
            headerView.iconImageView.image = UIImage(named: "home_header_phone")
        }
        return headerView
    }
}

extension AmuseViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(#function)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: kScreenW, height: kSectionHeaderViewH)
    }
}

// MARK: 接收通知方法
extension AmuseViewController {

   @objc fileprivate func aumsePageViewButtonClickNotification(notification: NSNotification){

        let userInfo = notification.userInfo as! [String: AmuseTopModel]
        let model = userInfo[kAumsePageViewButtonClick]

        print(model?.icon_url ?? "")
    }
}

