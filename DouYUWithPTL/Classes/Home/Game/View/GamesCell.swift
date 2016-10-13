//
//  GamesCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/8.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage
class GamesCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var gamesModel: GamesModel? {
        didSet {
            
            nameLabel.text = gamesModel?.tag_name
            
            imageIconView.sd_setImage(with: URL(string:(gamesModel?.pic_url)!), placeholderImage: UIImage(named: "Img_default"))
        }
    }
}
