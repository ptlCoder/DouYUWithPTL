//
//  GamesHeaderView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/9.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class GamesHeaderView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = UIColor.orange
    }
    
}
