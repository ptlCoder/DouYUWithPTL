//
//  GameTopView.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/10/9.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class GameTopView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = [.init(rawValue: 0)]
        
        
        
    }
    
    class func gameView() -> GameTopView {
        return Bundle.main.loadNibNamed("GameTopView", owner: nil, options: nil)?.first as! GameTopView
    }

}
