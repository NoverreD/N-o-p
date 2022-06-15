//
//  LazySequenceViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/3/28.
//

import UIKit

class LazySequenceViewController: UIViewController {

    var vc: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLazySequence()
    }
    
    func getLazySequence() -> [UIViewController] {
        var childViewControllerClass = [UIViewController.Type]()
        
        childViewControllerClass.append(AVC.self)
        childViewControllerClass.append(BVC.self)
        childViewControllerClass.append(CVC.self)
        
        return childViewControllerClass.lazy.map({ $0.init()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(vc[0])
    }
}

extension LazySequenceViewController {
    class AVC: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            print("\(#function) - AVC")
        }
        
        init() {
            super.init(nibName: nil, bundle: nil)
            print("\(#function) - AVC")
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class BVC: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            print("\(#function) - BVC")
        }
        
        init() {
            super.init(nibName: nil, bundle: nil)
            print("\(#function) - BVC")
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class CVC: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            print("\(#function) - CVC")
        }
        
        init() {
            super.init(nibName: nil, bundle: nil)
            print("\(#function) - CVC")
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
