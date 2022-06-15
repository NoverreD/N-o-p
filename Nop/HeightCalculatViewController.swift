//
//  HeightCalculatViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/7/23.
//

import UIKit
import SnapKit

class HeightCalculatViewController: UIViewController {

    var valueForWork: Int = 0
    let helper = OneNHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        addLayout()
        for _ in 0...100 {
            DispatchQueue.global(qos: .default).async {
                self.helper.oneAction {
                    self.valueForWork += 1
                }
            }
        }
        
        for _ in 0...100 {
            DispatchQueue.global(qos: .default).async {
                print("value = \(self.valueForWork)")
            }
        }
    }
    
    lazy var containerView: ContainerView = {
        let temp = ContainerView()
        temp.backgroundColor = UIColor.red
        return temp
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let temp = UIView()
        temp.backgroundColor = UIColor.randomColor
        containerView.addTargetView(temp,animationDuration: 5)
    }
    
    lazy var sliderView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.randomColor
        return temp
    }()
}


extension HeightCalculatViewController {
    func setupSubview() {
        view.addSubview(containerView)
    }
    
    func addLayout() {
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(250).priority(.low)
        }
    }
}

class ContainerView: UIView {
    
    var heightConstraint: Constraint?
    
    lazy var titleButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("A Title", for: .normal)
        temp.backgroundColor = UIColor.gray
        return temp
    }()

    lazy var contentView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.blue
        return temp
    }()
    
    var targetView: UIView?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubview() {
        addSubview(titleButton)
        addSubview(contentView)
    }
    
    func addLayout() {
        titleButton.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleButton.snp.bottom)
            self.heightConstraint = make.height.equalTo(250).constraint
        }
    }
    
    func addTargetView(_ targetView: UIView, animationDuration: TimeInterval? = nil){
        let duration = animationDuration ?? 0.3
        contentView.addSubview(targetView)
        targetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.layoutIfNeeded()
        let oldView = self.targetView
        self.heightConstraint?.update(offset: 300)
        UIView.animate(withDuration: duration) {
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            oldView?.removeFromSuperview()
        }
        self.targetView = targetView
    }
}
