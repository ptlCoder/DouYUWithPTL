//
//  GamesModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class GamesModel: NSObject {

    var tag_name : String = ""
    var pic_url : String = ""
    var tag_id : Int = 0
    var count : Int = 0
    
    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
