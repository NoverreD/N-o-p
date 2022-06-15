//
//  KeyboardViewController3.swift
//  NopKB
//
//  Created by dengzhihao on 2021/6/11.
//

import UIKit
import SnapKit

class KeyboardViewController3: UIInputViewController {

    fileprivate var containerViewHeightConstrain: NSLayoutConstraint?
    fileprivate var containerViewBottomConstrain: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        addSubviews()
        addLayout()
        view.addSubview(layoutView)
        layoutView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
//        addHeightConstraint()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("w:\(view.bounds.width), h:\(view.bounds.height) | \(#function)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("w:\(view.bounds.width), h:\(view.bounds.height) | \(#function)")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        containerViewHeightConstrain?.constant = containerViewHeight(from: newCollection)
        super.willTransition(to: newCollection, with: coordinator)
        print("w:\(view.bounds.width), h:\(view.bounds.height) | \(#function)")
    }
    
    func containerViewHeight(from collection: UITraitCollection? = nil) -> CGFloat {
        let collection = collection ?? UITraitCollection.current
        if (collection.verticalSizeClass == .compact) {
            return 230
        }
        return 280
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("w:\(view.bounds.width), h:\(view.bounds.height) | \(#function) | new size:\(size)")
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        print("\(#function) - start")
        guard let text = text(textInput) else {
            return
        }
        print("\(#function) | \(text)")
    }
    
    override func selectionDidChange(_ textInput: UITextInput?) {
        print("\(#function) - start")
        guard let text = text(textInput) else {
            return
        }
        print("\(#function) | \(text)")
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        print("\(#function) - start")
        super.textDidChange(textInput)
        guard let text = text(textInput) else {
            return
        }
        print("\(#function) | \(text)")
    }
    
    lazy var layoutView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.gray
        return temp
    }()
    
    lazy var containerView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.yellow
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textDocumentProxy.insertText("Abc")
        guard let path = Bundle.main.path(forResource: "NavicatPremium15029", ofType: "zip") else {
            return
        }
        let tagetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/sdkf.zip")
        do {
            try FileManager.default.copyItem(atPath: path, toPath: tagetPath)
        } catch let error {
            print(error)
        }
    }
}

extension KeyboardViewController3 {
    func addSubviews() {
        view.addSubview(containerView)
    }
    
    func addLayout() {
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        containerViewHeightConstrain = containerView.heightAnchor.constraint(equalToConstant: containerViewHeight())
        containerViewHeightConstrain?.priority = UILayoutPriority(999)
        containerViewHeightConstrain?.isActive = true
        let temp = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        temp.isActive = true
    }
    
    func addHeightConstraint(){
        let temp = view.heightAnchor.constraint(equalToConstant: 300)
        temp.priority = UILayoutPriority(999)
        temp.isActive = true
    }
    
    func text(_ textInput: UITextInput?) -> String? {
        guard let textInput = textInput,
              let range = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument) else {
            return nil
        }
        let text = textInput.text(in: range)
        return text
    }

}
