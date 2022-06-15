//
//  LayoutGuideViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/22.
//

import UIKit

class LayoutGuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubview()
        addLayout()
    }
    
    lazy var topImageView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        temp.image = UIImage(named: "myImage-2")
        return temp
    }()
    
    lazy var bottomLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.text = "A mesage from ..."
        return temp
    }()

}

extension LayoutGuideViewController {
    func setupSubview() {
        view.addSubview(topImageView)
        view.addSubview(bottomLabel)
    }
    
    func addLayout() {
                
        let containerLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(containerLayoutGuide)
        
        
        containerLayoutGuide.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        topImageView.snp.makeConstraints { make in
            make.left.right.equalTo(containerLayoutGuide)
            make.top.equalTo(containerLayoutGuide)
            make.height.equalTo(300)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(containerLayoutGuide)
            make.top.equalTo(topImageView.snp.bottom).offset(20)
        }
    }
}
