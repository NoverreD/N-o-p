//
//  ButtonViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/8/31.
//

import UIKit

class ButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        addLayout()
    }
    

    var isButtonSelected = false
    
    lazy var button: UIButton = {
        let temp = HookButton()
        temp.setTitle("normalTitle", for: .normal)
        temp.backgroundColor = UIColor.red
        temp.setImage(UIImage(named: "AppIcon"), for: .normal)
        temp.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
        temp.imageView?.layer.cornerRadius = (temp.imageView?.image?.size.height ?? 0) / 2.0
        temp.imageView?.clipsToBounds = true
        return temp
    }()
    
    lazy var button2: UIButton = {
        let temp = HookButton()
        temp.setTitle("normalTitle", for: .normal)
        temp.setTitle("longlongTitle", for: .selected)
        temp.backgroundColor = UIColor.red
        temp.setImage(UIImage(named: "setImage"), for: .normal)
        temp.addTarget(self, action: #selector(onButton2(sender:)), for: .touchUpInside)
        temp.imageView?.layer.cornerRadius = (temp.imageView?.image?.size.height ?? 0) / 2.0
        temp.imageView?.clipsToBounds = true
        return temp
    }()
    
    lazy var button3: UIButton = {
        let temp = HookButton()
        temp.setTitle("normalTitle", for: .normal)
        temp.backgroundColor = UIColor.red
        temp.setImage(UIImage(named: "AppIcon"), for: .normal)
        temp.addTarget(self, action: #selector(onButton3(sender:)), for: .touchUpInside)
        return temp
    }()

    @objc func onButton(sender: Any) {
        isButtonSelected = !isButtonSelected
        self.button.setTitle(self.isButtonSelected ? "longlongTitle" : "normalTitle", for: .normal)
        
        UIView.animate(withDuration: 1) {
            self.button.layoutIfNeeded()
        }
    }
    
    @objc func onButton2(sender: Any) {
        button2.isSelected = !button2.isSelected
        self.button2.setTitle("normalTitle2", for: .selected)
        print("\(#function)")
        UIView.animate(withDuration: 1) {
//            self.button2.layoutIfNeeded()
            self.button2.imageView?.transform = self.button2.isSelected ? CGAffineTransform.init(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
            
        }
//        UIView.animate(withDuration: 1) {
//            self.button2.imageView?.transform = self.button2.isSelected ? CGAffineTransform.init(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
//        }
    }
    
    @objc func onButton3(sender: Any) {
//        button3.isSelected = !button3.isSelected
//        button3.setTitle(button3.isSelected ? "longlongTitle" : "normalTitle", for: .normal)
//        button3.sizeToFit()
//        UIView.animate(withDuration: 1) {
//            self.button3.layoutIfNeeded()
//        }
//
    }
}

extension ButtonViewController {
    func setupSubviews() {
        view.backgroundColor = UIColor.yellow
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    
    func addLayout() {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        button2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(button).offset(100)
        }
        
        button3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(button2).offset(100)
        }
    }
}


private class HookButton: UIButton {
    
    override var titleLabel: UILabel? {
        get {
            print("\(#function)")
            return super.titleLabel
        }
    }
    
    override func layoutIfNeeded() {
        if let label = titleLabel {
            label.backgroundColor = UIColor.blue
            label.contentMode = .redraw
        }
        super.layoutIfNeeded()
        print("\(#function)")
    }
    
    override func invalidateIntrinsicContentSize() {
        super.invalidateIntrinsicContentSize()
        print("\(#function)")
    }
    
    override var intrinsicContentSize: CGSize {
        let result = super.intrinsicContentSize
        print("\(#function)  \(result)")
        return result
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print("\(#function)")
    }
}
