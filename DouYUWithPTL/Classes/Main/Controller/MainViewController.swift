//
//  MainViewController.swift
//  DouYUWithPTL
//
//  Created by pengtanglong on 16/9/22.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")

    }

    
    fileprivate func addChildVC(_ stortName: String) {
        
        let childVC = UIStoryboard(name: stortName, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVC!)
        
    }
}
