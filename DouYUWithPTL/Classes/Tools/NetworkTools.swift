//
//  NetworkTools.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/27.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: NSObject {
    
    
//    //声明闭包
//    typealias SuccessClosure = ([AnyObject])->()
//    typealias FailureClosure = (Error)->()
//    
//    // MARK: 成功回调
//    var successBlock: SuccessClosure?
//    // MARK: 失败回调
//    var failuerBlock: FailureClosure?
//    
    
   class func Get_requestData(urlString: String, parameters: [String : String]? = nil, successCompletionHandler :  @escaping (_ result : [String : AnyObject]) -> (), failureCompletionHandler : @escaping (_ result : Error) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.get(urlString, parameters: parameters, progress: nil, success: { (task, responseObject) in
            
            // 将responseObject转化为非optional形式
            guard let dataGet = responseObject as? Data else {
                failureCompletionHandler("解析失败" as! Error)
                return
            }
            
            let obj = try? JSONSerialization.jsonObject(with: dataGet, options: .mutableLeaves) as! [String : AnyObject]
            
            successCompletionHandler(obj!)
            
            }) { (task, error) in
               failureCompletionHandler(error)
        }
        
    }
}
