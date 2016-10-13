//
//  AmuseTopModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 2016/10/11.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class AmuseTopModel: NSObject {

    // 标题
    var tag_name: String = ""
    // 图片
    var icon_url: String = ""
    
//    // 主播信息对应的字典
    var room_list : [[String : Any]]? {
        didSet {
            for dict in room_list! {
                amuse = PlayModel(dict: dict)
            }
        }
    }
    
    
    // 主播信息对应的模型对象
    var amuse : PlayModel?
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

