//
//  ContentLayoutGuideViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/11/23.
//

import UIKit

class ContentLayoutGuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.backgroundColor = UIColor.blue
        return temp
    }()
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.text = "asdfasdfasdf"
        return temp
    }()
}

extension ContentLayoutGuideViewController {
    func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(label)
    }
    
    func addLayout() {
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
        
        
    }
}
