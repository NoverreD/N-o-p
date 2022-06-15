//
//  LazyViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/8/5.
//

import UIKit

class LazyViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lazyView)
        UIView.animate(withDuration: 0) {
            self.view.addSubview(self.lazyView)
        } completion: { _ in
            print("thread: \(Thread.current)")
        }

    }
    
    lazy var lazyView: UIView = {
        print("hao: - start")
        let temp = UIView()
        print("hao: - end:")
        return temp
    }()
}
