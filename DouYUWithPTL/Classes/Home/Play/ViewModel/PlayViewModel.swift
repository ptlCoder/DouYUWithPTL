//
//  PlayViewModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&client_sys=ios&offset=0
// http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&client_sys=ios&offset=20
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&client_sys=ios&offset=40
import UIKit

class PlayViewModel: NSObject {

    lazy var palyModel : [PlayModel] = [PlayModel]()
}

extension PlayViewModel {
    
    func requestPlayData(finishCallback : @escaping () -> ()) {
        
        let parameters = ["limit" : "20", "offset" : "20"]
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&offset=0", parameters: parameters, successCompletionHandler: { (resonseObject) in
            
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.palyModel.append(PlayModel(dict: dict))
            }
            finishCallback()
            
            }) { (error) in
                print("请求失败")
        }
    }

}
