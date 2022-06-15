//
//  TransitionViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/22.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubview()
        addLayout()
    }
    
    lazy var containerView: UIView = {
        let temp = UIView()
        return temp
    }()

    lazy var aView: UIView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        temp.image = UIImage(named: "myImage-2")
        return temp
    }()
    
    lazy var bView: UIView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        temp.image = UIImage(named: "myImage")
        return temp
    }()
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        transitionInWayB()
    }
    
    func transitionInWayB() {
        var from = aView
        var to = bView
        if from.superview == nil {
            from = bView
            to = aView
        }
        
        UIView.transition(with: containerView, duration: 3, options: [.transitionCrossDissolve, ]) {
            from.removeFromSuperview()
            self.containerView.addSubview(to)
            to.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } completion: { flag in
            print("end1 - \(flag)")
        }
    }
    
    func transitionInWayA() {
        var from = aView
        var to = bView
        if from.isHidden {
            from = bView
            to = aView
        }
        UIView.transition(from: from, to: to, duration: 3, options: [.showHideTransitionViews, .transitionFlipFromBottom]) { flag in
            print("end2 - \(flag)")
        }
    }
}

extension TransitionViewController {
    func setupSubview() {
        view.addSubview(containerView)
        containerView.addSubview(aView)
//        containerView.addSubview(bView)
    }
    
    func addLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        aView.translatesAutoresizingMaskIntoConstraints = false
        bView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        containerView.addConstraints([
            containerView.heightAnchor.constraint(equalToConstant: 400),
        ])
        containerView.addConstraints([
            aView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            aView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            aView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            aView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
//        bView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
}
