//
//  EventViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/4/25.
//

import UIKit

class EventViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(aView)
        view.addSubview(bView)
        
        aView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
        }
        
        bView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(120)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) -1- \(self)")
        super.touchesBegan(touches, with: event)
        print("\(#function) -2- \(self)")
    }

    lazy var aView: View = {
        let temp = View()
        temp.name = "AAAAAAView"
        temp.backgroundColor = .randomColor
        return temp
    }()
    
    lazy var bView: View = {
        let temp = View()
        temp.name = "BBBBBBView"
        temp.backgroundColor = .randomColor
        return temp
    }()
}


extension EventViewController {
    class View: UIView {
        
        var name: String = ""
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("\(#function) -1- \(self)")
            super.touchesBegan(touches, with: event)
            print("\(#function) -2- \(self)")
        }
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            print("\(#function) -1- \(debugLabel ?? "")")
            let result = super.hitTest(point, with: event)
            print("\(#function) -2- \(debugLabel ?? "") -- \(result?.debugLabel ?? "")")
            return result
        }
        
        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            print("\(#function) -1- \(debugLabel ?? "")")
            let flag = super.point(inside: point, with: event)
            print("\(#function) -2- \(debugLabel ?? "") -- \(flag)")
            return flag
        }
    }
}

extension UIView {
    var debugLabel: String? {
        if let temp = self as? EventViewController.View {
            return temp.name
        }
        return nil
    }
}
