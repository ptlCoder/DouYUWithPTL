//
//  AmuseViewModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 2016/10/11.
//  Copyright © 2016年 pengtanglong. All rights reserved.
// http://capi.douyucdn.cn/api/v1/getHotRoom/2?time=1475896020


import UIKit

class AmuseViewModel: UIView {

    lazy var amuseModels : [AmuseTopModel] = [AmuseTopModel]()
    
}

extension AmuseViewModel {

    func requestTopViewData(_ finishCallBack: @escaping() -> ()) {
        
        let parameters = ["time" : NSDate.getCurrentTime()]
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: parameters, successCompletionHandler: { (resonseObject) in
            
            // 2.根据data该key,获取数组
            guard let dataArray = resonseObject["data"] as? [[String : Any]] else { return }
     
            // 3.2.获取主播数据
            for dict in dataArray {
                let amuse = AmuseTopModel(dict: dict)
                self.amuseModels.append(amuse)
            }
            
            finishCallBack()
            
            }) { (error) in
                print("数据请求不错误")
        }
    }
    
    
    
    
}
