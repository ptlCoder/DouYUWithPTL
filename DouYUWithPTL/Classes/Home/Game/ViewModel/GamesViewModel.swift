//
//  GamesViewModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//
//http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
import UIKit

class GamesViewModel: NSObject {

    // 滚动视图数据
    lazy var gamesModels : [GamesModel] = [GamesModel]()
}

// MARK: 请求滚动视图数据
extension GamesViewModel {
    
    // 请求无线轮播的数据
    func requestGamesData(finishCallback : @escaping () -> ()) {
        // 请求滚动视图数据
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"], successCompletionHandler: { (resonseObject) in
            
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.gamesModels.append(GamesModel(dict: dict))
            }
            finishCallback()
            
        }) { (error) in
            print("请求失败")
        }
    }
}
