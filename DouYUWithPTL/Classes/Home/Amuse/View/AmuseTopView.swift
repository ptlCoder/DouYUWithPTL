//
//  AmuseTopView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 2016/10/11.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class AmuseTopView: UIView {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    var pageNub: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = [.init(rawValue: 0)]
        
        widthConstraint.constant = 2 * kScreenW
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    

    
    
    var amuseTopModels : [AmuseTopModel]? {
        didSet {
            amuseTopModels?.removeFirst()
            pageNub = ((amuseTopModels?.count)! + 8 - 1)/8
            pageControl.numberOfPages = pageNub
            // 加载topView数据
            requestDataForScrollView()
        }
    }
}


extension AmuseTopView {

    fileprivate func requestDataForScrollView() {
    
        // 根据数组个数 来计算页数
        for i in 0..<pageNub {
            
            let topPageView = AumsePageView()
            topPageView.frame = CGRect(x: CGFloat(i)*kScreenW, y: 0, width: kScreenW, height: scrollView.bounds.height)
            scrollView.addSubview(topPageView)

            // 截取数组元素
            var left = i * 8
            var right: Int = 0
            
            let range = (amuseTopModels?.count)! - left
            if range >= 8 {
                left = 8 * i
                right = left + 8
            }else
            {
                left = 8 * i
                right = left + range
            }
            
            var models : [AmuseTopModel] = [AmuseTopModel]()
            
            let array = (amuseTopModels?[left..<right])!
            
            for model in array {
                models.append(model)
            }
            // 传值
            topPageView.amusePageModels = models
        }
    }
}

// MARK: scrollView代理
extension AmuseTopView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + 0.5 * frame.width
        pageControl.currentPage = Int(offsetX/frame.width)
    }
}

// MARK: 返回xib
extension AmuseTopView {
    class func amuseTopView() -> AmuseTopView {
        return Bundle.main.loadNibNamed("AmuseTopView", owner: nil, options: nil)?.first as! AmuseTopView
    }
}
