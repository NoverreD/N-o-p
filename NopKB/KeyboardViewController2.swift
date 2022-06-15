//
//  KeyboardViewController2.swift
//  NopKB
//
//  Created by dengzhihao on 2021/6/11.
//

import UIKit

class KeyboardViewController2: UIInputViewController {

    var nextKeyboardButton: UIButton!
    
    var viewHeigthConstraint: NSLayoutConstraint?
    
    var buttonBottomConstrain: NSLayoutConstraint?
        
    override var needsInputModeSwitchKey: Bool {
        return true
    }
    
    override func loadView() {
        let temp = MyInputView(frame: .zero, inputViewStyle: .keyboard)
        temp.delegate = self
//        temp.autoresizingMask = UIView.AutoresizingMask.init(rawValue: 0)
//        temp.allowsSelfSizing = true
        view = temp
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hao : \(#function)")
        
        viewHeigthConstraint = view.heightAnchor.constraint(equalToConstant: keyboardHeight())
        viewHeigthConstraint?.priority = UILayoutPriority(999)
        viewHeigthConstraint?.isActive = true
        
        view.addSubview(keyboardView)
        keyboardView.addSubview(contentView)
        keyboardView.addSubview(frameView)
        keyboardView.addSubview(autoLayoutView)

        view.backgroundColor = UIColor.red
        
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
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        buttonBottomConstrain = self.nextKeyboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        buttonBottomConstrain?.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        print("hao \(#function)")
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
//        if let sup = view.superview{
//            view.frame.size.width = sup.frame.width
//            view.frame.origin = sup.bounds.origin
//        }
//        view.frame.size.height = keyboardHeight()
        super.viewWillLayoutSubviews()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("hao \(#function)" + " w: \(view.bounds.width) h:\(view.bounds.height)")
        
        keyboardView.frame.origin = CGPoint.zero
        keyboardView.frame.size.width = view.bounds.width
        contentView.frame = keyboardView.bounds.insetBy(dx: 10, dy: 10)
        
        let frameViewWidth: CGFloat = 80
        frameView.frame = CGRect(x: keyboardView.bounds.width - frameViewWidth - 10, y: keyboardView.bounds.height - 50 - 10, width: frameViewWidth, height: 50)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("hao \(#function) size: \(size)")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        print("hao \(#function) oldH: \(viewHeigthConstraint!.constant), newH:\(keyboardHeight(collection: newCollection))")
//        viewHeigthConstraint?.constant = keyboardHeight(collection: newCollection)
        print("hao \(#function) size-1: \(view.bounds.size)")
        viewHeigthConstraint?.constant = keyboardHeight(collection: newCollection)
        view.constraints.first { constrain in
            return constrain.priority.rawValue == 1000 && constrain.firstAttribute == .height
        }?.constant = keyboardHeight(collection: newCollection)
        if let constant = buttonBottomConstrain?.constant {
            buttonBottomConstrain?.constant = constant - 200
        }
        coordinator.animate { c in
            print("ssss")
            self.view.superview?.layoutIfNeeded()
            self.nextKeyboardButton.superview?.layoutIfNeeded()
            self.keyboardView.frame.size.height = self.keyboardHeight(collection: newCollection)
        } completion: { _ in

        }

//        view.frame.size.height = keyboardHeight(collection: newCollection)
        super.willTransition(to: newCollection, with: coordinator)
        print("hao \(#function) size-2: \(view.bounds.size)")
        print("hao \(#function) size-3: \(UIScreen.main.bounds.size)")
        print("hao \(#function) newCollection.w: \(newCollection.horizontalSizeClass.rawValue), h:\(newCollection.verticalSizeClass.rawValue)")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("hao \(#function)")
        super.traitCollectionDidChange(previousTraitCollection)
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
        return temp
    }()
    
    lazy var contentView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.gray
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
    
    func keyboardHeight(collection: UITraitCollection? = nil) -> CGFloat{
        let collection = collection ?? UITraitCollection.current
        if collection.verticalSizeClass == .compact {
            return 250
        }else{
            return 300
        }
    }
}

extension KeyboardViewController2: MyInputViewDelegate {
    func intrinsicContentSize(_ inputView: MyInputView) -> CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: keyboardHeight())
    }
}

protocol MyInputViewDelegate: NSObjectProtocol {
    func intrinsicContentSize(_ inputView: MyInputView) -> CGSize
}

class MyInputView: UIInputView {
    
    weak var delegate: MyInputViewDelegate?
    
    override var allowsSelfSizing: Bool {
        get {
            return true
        }
        set {
            print("allowsSelfSizing: \(newValue)")
        }
    }
    
    override var intrinsicContentSize: CGSize{
        let size = delegate?.intrinsicContentSize(self)
        return size ?? super.intrinsicContentSize
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        print("hao: \(#function) targetSize: \(targetSize)")
        return super.systemLayoutSizeFitting(targetSize)
    }
    
//    override var autoresizingMask: UIView.AutoresizingMask {
//        didSet {
//            var temp = autoresizingMask
//            super.autoresizingMask = temp.remove(.flexibleWidth) ?? temp
//        }
//    }
}
