//
//  HomeViewModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/23.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import MJExtension
import Dispatch

class HomeViewModel: NSObject {
    // MARK:- 懒加载属性
    
    // 热门数据 模型
    fileprivate lazy var bigDataGroup = AnchorGroup()
    // 颜值数据 模型
    fileprivate lazy var prettyGroup = AnchorGroup()
    // 游戏数据 数组
    lazy var anchorGroups = [AnchorGroup]()

    // 滚动视图数据
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

// MARK: 列表数据
extension HomeViewModel {
    func requestData(finishCallBack: @escaping () -> ()) {

        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        // 创建Group
        let dGroup = DispatchGroup()
        
    /// 第一组数据
//        进入组
        dGroup.enter()
//        http://capi.douyucdn.cn/api/v1/getbigDataRoom?limit=4&offset=0&time=1475051945
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters , successCompletionHandler: { (resonseObject) in
            
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }

            //离开组
            dGroup.leave()
            
            }) { (error) in
              print("请求失败")
        }
    
    /// 第二组数据 颜值
        dGroup.enter()
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, successCompletionHandler: { (resonseObject) in
            
            // 2.根据data该key,获取数组
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }


            dGroup.leave()
            }) { (error) in
                print("请求失败")
        }
        
        /// 后面数据 游戏
        dGroup.enter()
        NetworkTools.Get_requestData(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters, successCompletionHandler: { (resonseObject) in
            
            // 2.根据data该key,获取数组
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            dGroup.leave()
            
            }) { (error) in
                print("请求失败")
        }
        
        // 所有的数据都请求到,之后进行排序
        
        __dispatch_group_notify(dGroup, DispatchQueue.main){
        
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
              finishCallBack()
        }
    }
}

// MARK: 请求滚动视图数据
extension HomeViewModel {
    
    // 请求无线轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        // 请求滚动视图数据
        NetworkTools.Get_requestData(urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"], successCompletionHandler: { (resonseObject) in
            
            guard let dataArray = resonseObject["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
            
        }) { (error) in
            print("请求失败")
        }
    }
}
