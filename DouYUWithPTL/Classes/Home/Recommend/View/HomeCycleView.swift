//
//  HomeCycleView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

private let collectionViewCycleID = "collectionViewCycleID"
private let kCycleViewH = kScreenW * 3 / 8
private let timeInterval = 3.0

class HomeCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer : Timer? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = [.init(rawValue: 0)]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: collectionViewCycleID)

    }
    
    //
    var cycleModels : [CycleModel]? {
        didSet {
            // 刷新数据
            collectionView.reloadData()
            
            // 页数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 默认某个位子
            let indexpath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexpath as IndexPath, at: .left, animated: true)
            
            // 添加定时器
            removeCyeleViewTimer()
            addCyeleViewTimer()
        }
    }
    
   class func cycleView() -> HomeCycleView {
    
        return Bundle.main.loadNibNamed("HomeCycleView", owner: nil, options: nil)?.first as! HomeCycleView
    }
}


// MARK:- 设置UI界面内容
extension HomeCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCycleID, for: indexPath) as! CollectionViewCycleCell
        
        let cycleMoel = cycleModels?[indexPath.item % (cycleModels?.count)!]
        
        cell.cycleMoel = cycleMoel
        
        return cell
    }
    
}

extension HomeCycleView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView.bounds.size
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     
        return 0
    }
    
}

extension HomeCycleView {
    // 添加定时器
    fileprivate func addCyeleViewTimer() {
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(self.scrollviewToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    // 移除定时器
    fileprivate func removeCyeleViewTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 滚动到下一页
    @objc fileprivate func scrollviewToNextPage(){
        // 下一页的偏移量
        let nextPageOffsetX = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: nextPageOffsetX, y: 0), animated: true)
    }
}
// MARK: UIScrollViewDelegate
extension HomeCycleView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView){
    
        // 偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 当前页数
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
        removeCyeleViewTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
        addCyeleViewTimer()
    }
}

