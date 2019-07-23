//
//  ViewController.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/21/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var serverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        displayServer()
    }

    private func displayServer() {
        #if DEV
            serverLabel.text = "This is DEV server"
        #elseif STG
            serverLabel.text = "This is STAGING server"
        #else
            serverLabel.text = "This is PRODUCTION server"
        #endif
    }

}

