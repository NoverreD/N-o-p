//
//  LayoutView.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/1.
//

import UIKit

class LayoutView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubview()
        addLayout()
    }
    
    private func setupSubview() {
        backgroundColor = UIColor.green
//        addSubview(aView)
        addSubview(aLabel)
    }
    
    private func addLayout() {
//        aView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
//        }
        
        aLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("\(LayoutView.self) \(#function)")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("\(LayoutView.self) \(#function)")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print("\(LayoutView.self) \(#function)")
    }
    
    lazy var aView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.brown
        return temp
    }()
    
    lazy var aLabel: UILabel = {
        let temp = MyLabel2()
        temp.backgroundColor = UIColor.red
        temp.text = "ABBNNKK"
        temp.textColor = UIColor.yellow
        temp.numberOfLines = 0
        temp.textAlignment = .center
        return temp
    }()
}


class MyLabel2: UILabel {
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print("\(MyLabel2.self) \(#function)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("\(MyLabel2.self) \(#function)")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("\(MyLabel2.self) \(#function)")
    }
}
