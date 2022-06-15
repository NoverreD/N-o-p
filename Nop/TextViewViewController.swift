//
//  TextViewViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/8/24.
//

import UIKit

class TextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        addLayout()
    }
    
    lazy var borderView: UIView = {
        let temp = UIView()
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.yellow.cgColor
        return temp
    }()
    
    lazy var labelBorderView: UIView = {
        let temp = UIView()
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.yellow.cgColor
        return temp
    }()
    
    func fetchAttributedText() -> NSAttributedString {
        let text = "👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👔🙂😉😌🙃😜🙂😉😌🙃😜🙂😉😌🙃😜ヤンキーな愛情🙂😉😜か～？？CP名🙂😉😌🙃😜🙂😉😌🙃😜🙂😉😌🙃😜👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👔"
        let font = UIFont(name: "HiraKakuProN-W3", size: 17)// UIFont.systemFont(ofSize: 17)
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping
        style.lineSpacing = 20
        let attributeText = NSAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.font: font,
                                                            NSAttributedString.Key.foregroundColor: UIColor.black,
                                                            NSAttributedString.Key.backgroundColor: UIColor.red])
        return attributeText
    }
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.backgroundColor = UIColor.red
        temp.textColor = UIColor.black
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = UIColor.green
        temp.attributedText = fetchAttributedText()
        temp.textContainer.lineFragmentPadding = 0
        temp.layoutManager.usesFontLeading = false
        temp.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return temp
    }()
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = UIColor.blue
//        temp.attributedText = fetchAttributedText()
        temp.text = fetchAttributedText().string
        temp.numberOfLines = 0
        return temp
    }()
    
    lazy var myView: MyView = {
        let temp = MyView()
        temp.backgroundColor = UIColor.purple
        return temp
    }()
    
    lazy var myViewB: MyView = {
        let temp = MyView()
        temp.backgroundColor = UIColor.brown
        return temp
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let rulerSize = CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude)
        
        let textHeight = textView.sizeThatFits(rulerSize).height -  textView.textContainerInset.top - textView.textContainerInset.bottom
        let inset = (textView.frame.height - textHeight) / 2.0
        textView.textContainerInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        borderView.snp.updateConstraints { make in
            make.top.equalTo(textView).offset(textView.textContainerInset.top)
            make.height.equalTo(textHeight)
        }
        
        let textHeight2 = label.attributedText!.boundingRect(with: rulerSize,
                                                             options: [.usesLineFragmentOrigin],
                                                             context: nil).height
//        let textHeight2 = label.sizeThatFits(rulerSize).height
        labelBorderView.snp.updateConstraints { make in
            make.height.equalTo(textHeight2)
        }
    }

    private func setupSubview() {
        view.addSubview(textView)
        view.addSubview(borderView)
        view.addSubview(label)
        view.addSubview(labelBorderView)
        view.addSubview(myView)
        view.addSubview(myViewB)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myViewB.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 30)
    }
    
    private func addLayout() {
        textView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        borderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalTo(textView).offset(0)
            make.height.equalTo(textView.contentSize.height)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        labelBorderView.snp.makeConstraints { make in
            make.right.left.centerY.equalTo(label)
            make.height.equalTo(0)
        }
        
        myView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
}


class MyView: UIView {
    override func updateConstraints() {
        print("\(self) \(#function)")
        super.updateConstraints()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        let result = super.requiresConstraintBasedLayout
        print("\(self) \(#function) \(result)")
        return result
    }
}
