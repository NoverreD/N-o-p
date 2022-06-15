//
//  ConcurrentViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/27.
//

import UIKit

class ConcurrentViewController: UIViewController {

    var count = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for _ in 1...2000 {
//            let timeStamp = Date().timeIntervalSince1970
//            DispatchQueue.global(qos: .default).async {
//                self.count = [2,3,5]
////                print("count = \(self.count) -- \(timeStamp) - \(Thread.current)")
//            }
//        }
//
//        for i in 1000...1003 {
//            let timeStamp = Date().timeIntervalSince1970
//            var temp = count
//            temp.append(i)
//            count = temp
//            print("count = \(self.count) -- \(timeStamp) - \(Thread.current)")
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end - count = \(count)")
    }
}

