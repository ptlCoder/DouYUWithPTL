//
//  PrettyCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/28.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PrettyCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
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
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.昵称的显示
            nickNameLabel.text = model.nickname

            // 3.所在的城市
            cityBtn.setTitle(model.anchor_city, for: .normal)
            // 4.设置封面图片
            guard let iconURL = URL(string: model.vertical_src) else { return }
            iconImageView.sd_setImage(with: iconURL, placeholderImage: UIImage(named: "Img_default"))
        }
    }

}
