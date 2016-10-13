//
//  AmuseModel.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PlayModel: NSObject {

    var room_id : Int = 0
    var room_name : String = ""
    var room_src : String = ""
    var nickname : String = ""
    var online : Int = 0

    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
