//
//  AumsePageView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 2016/10/11.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import UserNotifications

// label的高度
private let labelH: CGFloat = 30
// 竖直间隙
private let marginY: CGFloat = 10
// 水平间隙
private let marginX: CGFloat = 20
// label字体大小
private let labelFontSize: CGFloat = 13


class AumsePageView: UIView {
    
    var amusePageModels : [AmuseTopModel]? {
        didSet {
            
            // 创建button
            
            rankWithTotalColumnsButtonWOrButtonH(totalColumns: 4, amuseModels: amusePageModels!)
            
        }
    }
}



// MARK: - 创建button
extension AumsePageView {
    func rankWithTotalColumnsButtonWOrButtonH(totalColumns:Int, amuseModels:[AmuseTopModel]){

        let buttonH:CGFloat = (frame.height - 3*marginY-2*labelH)/2
        let buttonW:CGFloat = buttonH

        if (amuseModels.count) > 0 {
            
            for index in 0 ..< amuseModels.count{
                
                let buttonView = UIButton(type: .custom)
                //行号
                let row : Int = index / totalColumns;
                //列号
                let col : Int = index % totalColumns;
                // 中间水平间隙
                let marginCenter = (frame.width - CGFloat(totalColumns) * buttonW - 2 * marginX)/CGFloat(totalColumns-1)
                let buttonX : CGFloat = marginX + CGFloat(col) * (buttonW + marginCenter);
                let buttonY : CGFloat = marginY + CGFloat(row) * (buttonH + labelH + marginY);
                buttonView.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH);
                // 圆形
                buttonView.layer.cornerRadius = buttonW*0.5
                buttonView.layer.masksToBounds = true
                addSubview(buttonView)
                
                // 点击
                buttonView.addTarget(self, action: #selector(self.didClickButton(_:)), for: .touchUpInside)
                buttonView.tag = index
                let url = amuseModels[index].icon_url
                buttonView.sd_setImage(with: URL(string: url), for: .normal)
                
                // 创建label
                let label = UILabel()
                let labelX : CGFloat = buttonX
                let labelY : CGFloat = buttonView.frame.maxY
                let w:CGFloat = buttonW
                let h:CGFloat = labelH
                label.frame = CGRect(x: labelX, y: labelY, width: w, height: h)
                addSubview(label)
                label.text = amuseModels[index].tag_name
                label.textColor = UIColor.init(r: 97, g: 97, b: 97)
                label.font = UIFont.systemFont(ofSize: labelFontSize)
                label.textAlignment = .center
            }
        }
    }
}

extension AumsePageView {

    func didClickButton(_ button: UIButton) {
        
        // 发送通知
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: kAumsePageViewButtonClickNotification), object: nil, userInfo: [kAumsePageViewButtonClick : (amusePageModels?[button.tag])!])
    }
}
