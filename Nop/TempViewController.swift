//
//  TempViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/12/27.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tempPath = NSTemporaryDirectory()
        
        let homePath = NSHomeDirectory()
        
        print(tempPath)
        print(homePath)
    }
}
