//
//  NormalCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/27.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage
class NormalCell: UICollectionViewCell {

    @IBOutlet weak var imageIconView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    var model : AnchorModel?{
        didSet{
            guard let model = model else {
                return
            }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if model.online >= 10000 {
                onlineStr = "\(Int(model.online / 10000))万在线"
            } else {
                onlineStr = "\(model.online)在线"
            }
            onlineLabel.text = onlineStr
            
            // 2.昵称的显示
            nickNameLabel.text = model.nickname

            // 3.房间名称
            roomNameLabel.text = model.room_name
            // 4.设置封面图片
            guard let iconURL = URL(string: model.vertical_src) else { return }
            imageIconView.sd_setImage(with: iconURL, placeholderImage: UIImage(named: "Img_default"))
        }
    }
    

}
