//
//  CollectionViewGameCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var groups :AnchorGroup? {
        didSet {
            
            titleLabel.text = groups?.tag_name
            
            guard let iconURL = URL(string: (groups?.icon_url)!) else { return }
            imageIconView.sd_setImage(with: iconURL, placeholderImage: UIImage(named: "home_more_btn"))
        }
    
    }
    

}
