//
//  LabelViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/22.
//

import UIKit

class LabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(aLayoutView)
        setupSubview()
        addLayout()
    }
    
    private func setupSubview() {
        view.addSubview(aLayoutView)
    }

    private func addLayout() {
        aLayoutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        aLayoutView.layoutIfNeeded()
        print("-------")
        aLayoutView.aLabel.text = (aLayoutView.aLabel.text ?? "") + "kmasdf"
        print("----2222---")
//        aLayoutView.setNeedsLayout()
        aLayoutView.layoutIfNeeded()
    }
    
    lazy var aLayoutView: LayoutView = {
        let temp = LayoutView(frame: UIScreen.main.bounds)
        return temp
    }()

}
