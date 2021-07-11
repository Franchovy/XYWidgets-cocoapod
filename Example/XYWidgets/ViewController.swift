//
//  ViewController.swift
//  XYWidgets
//
//  Created by Franchovy on 07/10/2021.
//  Copyright (c) 2021 Franchovy. All rights reserved.
//

import UIKit
import XYWidgets

class ViewController: UIViewController {

    @IBOutlet weak var xyButton: XYButton?
    @IBOutlet weak var normalButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalButton?.setTitle("Normal Button", for: .normal)
        xyButton?.setTitle("XY Button", for: .normal)
        
        xyButton?.backgroundColor = .blue
        xyButton?.borderGradient = [.blue, .green, .white, .yellow]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

