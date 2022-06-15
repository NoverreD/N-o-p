//
//  StringRaceViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/3/17.
//

import UIKit

class StringRaceViewController: UIViewController {

    private var shareGroupPath: String?
    
    private let iOOperationsQueue: OperationQueue = {
        let temp = OperationQueue()
        temp.maxConcurrentOperationCount = 1
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for i in 0..<10000 {
            DispatchQueue.global(qos: .background).async {
                self.updateShareGroupPath("http", index: i)
            }
            self.handlerWithPath("http://www.baidu.com", index: i)
        }
    }
    
    private func updateShareGroupPath(_ path: String?, index: Int) {
        self.shareGroupPath = path
        print("\(#function): \(index) - \(Thread.current)")
    }
    
    private func handlerWithPath(_ path: String, index: Int) {
        
        iOOperationsQueue.addOperation {
            
            if let shareGroupPath = self.shareGroupPath,
               path.hasPrefix(shareGroupPath),
               let temp = self.actionA() {
                _ = temp + 1
                print("\(#function): \(index) - \(Thread.current)")
            }
        }
        
    }
    
    private func actionA() -> Int? {
        return 9
    }

}
