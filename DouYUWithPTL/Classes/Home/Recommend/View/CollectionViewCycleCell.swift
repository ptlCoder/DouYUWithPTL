//
//  CollectionViewCycleCell.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/29.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCycleCell: UICollectionViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    // 标题
    @IBOutlet weak var titleContenLabel: UILabel!
    // 图片
    @IBOutlet weak var imageIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cycleMoel : CycleModel? {
        
        didSet {
            titleContenLabel.text = cycleMoel?.title
            
            guard let iconURL = URL(string: (cycleMoel?.pic_url)!) else { return }
            imageIconView.sd_setImage(with: iconURL, placeholderImage: UIImage(named: "Img_default"))
        
        }
    
    }

}
