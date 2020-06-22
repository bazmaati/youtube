//
//  ViewController.swift
//  youtube
//
//  Created by Barry Flanigan on 21/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()

    }


}

