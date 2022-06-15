//
//  KeyboardViewController.swift
//  NopKB
//
//  Created by dengzhihao on 2021/6/3.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    private var contentHeightConstraint: NSLayoutConstraint?
        
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override var needsInputModeSwitchKey: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hao : \(#function)")
        
        view.addSubview(keyboardView)
        keyboardView.addSubview(contentView)
        keyboardView.addSubview(frameView)
        keyboardView.addSubview(autoLayoutView)

        view.backgroundColor = UIColor.red
        
        keyboardView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        keyboardView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let temp = keyboardView.topAnchor.constraint(equalTo: view.topAnchor)
        temp.priority = UILayoutPriority(999)
        temp.isActive = true
        
        contentView.leftAnchor.constraint(equalTo: keyboardView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: keyboardView.rightAnchor, constant: 00).isActive = true
        contentView.bottomAnchor.constraint(equalTo: keyboardView.bottomAnchor, constant: 00).isActive = true
        contentView.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: 0).isActive = true
        contentHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 300)
        contentHeightConstraint?.isActive = true
        
        autoLayoutView.leftAnchor.constraint(equalTo: keyboardView.leftAnchor, constant: 10).isActive = true
        autoLayoutView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        autoLayoutView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        autoLayoutView.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: 10).isActive = true
        
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.backgroundColor = UIColor.blue
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList2(from:with:)), for: .touchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("w: \(view.bounds.width) h:\(view.bounds.height)")
        let frameViewWidth: CGFloat = 80
        frameView.frame = CGRect(x: view.bounds.width - frameViewWidth - 10, y: view.bounds.height - 50 - 10, width: frameViewWidth, height: 50)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("hao \(#function) size: \(size)")

    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let contentHeightConstraint = contentHeightConstraint else {
            return
        }
        let oldConstant = contentHeightConstraint.constant
        if newCollection.verticalSizeClass == .compact {
            contentHeightConstraint.constant = 250
        }else{
            contentHeightConstraint.constant = 300
        }
        if (oldConstant != contentHeightConstraint.constant) {
            contentView.setNeedsUpdateConstraints()
        }
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

    lazy var keyboardView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.green
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    lazy var contentView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.gray
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    lazy var frameView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.yellow
        return temp
    }()
    
    lazy var autoLayoutView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.purple
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func handleInputModeList(from view: UIView, with event: UIEvent) {
        super.handleInputModeList(from: view, with: event)
    }
    
    @objc func handleInputModeList2(from view: UIView, with event: UIEvent) {
        print("hao \(#function) size: \(self.view.bounds.size)")
    }
    
}

