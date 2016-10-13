//
//  PlayCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage

class PlayCell: UICollectionViewCell {

    @IBOutlet weak var onlineNumbel: UIButton!
    
    @IBOutlet weak var roomImage: UIImageView!
    
    @IBOutlet weak var nickname: UIButton!
    
    @IBOutlet weak var room_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var playModel: PlayModel? {
        didSet {

            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if (playModel?.online)! >= 10000 {
                onlineStr = "\(Int((playModel?.online)! / 10000))万"
            } else {
                onlineStr = "\((playModel?.online)!)"
            }
            onlineNumbel.setTitle(String(describing: onlineStr), for: .normal)
            nickname.setTitle(String(describing: playModel?.nickname ?? ""), for: .normal)
            room_name.text = playModel?.room_name
            roomImage.sd_setImage(with: URL(string: (playModel?.room_src)!), placeholderImage: UIImage(named: "Img_default"))
        }
    }

}
