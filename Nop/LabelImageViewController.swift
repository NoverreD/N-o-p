//
//  LabelImageViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/21.
//

import UIKit

class LabelImageViewController: UIViewController {

    private var performFont: UIFont? = UIFont.systemFont(ofSize: 35, weight: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
//        view.addSubview(textField)
        view.addSubview(changeFontButton)
        view.addSubview(textView)
        NotificationCenter.default.addObserver(self, selector: #selector(onTextFiledTextDidChange(noti:)), name: UITextView.textDidChangeNotification, object: textView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var markY: CGFloat = 100
        imageView.frame = CGRect(x: 8, y: markY, width: view.bounds.width-16, height: view.bounds.width-16)
        markY = imageView.frame.maxY + 20
        changeFontButton.frame = CGRect(x: (view.bounds.width-100) / 2, y: markY, width: 100, height: 50)
        markY = changeFontButton.frame.maxY + 20
        textView.frame = CGRect(x: 10, y: markY, width: view.bounds.width-16, height: view.bounds.width-16)
    }
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.white
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.black.cgColor
        temp.layer.cornerRadius = 1
        return temp
    }()
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.backgroundColor = UIColor.black
        temp.textColor = UIColor.black
        temp.textAlignment = .center
        return temp
    }()
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.textContainer.lineFragmentPadding = 0
        temp.layoutManager.usesFontLeading = false
        temp.backgroundColor = nil
        return temp
    }()
    
    lazy var textField: UITextField = {
        let temp = UITextField()
        temp.backgroundColor = UIColor.gray
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.black.cgColor
        temp.layer.cornerRadius = 1
        return temp
    }()
    
    lazy var changeFontButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("font", for: .normal)
        temp.backgroundColor = UIColor.yellow
        temp.addTarget(self, action: #selector(onFontButton(sender:)), for: .touchUpInside)
        return temp
    }()
}

// MARK: - UITextFieldDelegate
extension LabelImageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

// MARK: - FontViewControllerDelegate
extension LabelImageViewController: FontViewControllerDelegate {
    func fontViewController(_ viewController: FontViewController, didSelect font: UIFont?) {
        navigationController?.popViewController(animated: true)
        performFont = font
        handleWhenTextDidChange(text: textField.text)
    }
}

extension LabelImageViewController {
    @objc func onFontButton(sender: UIButton) {
        view.endEditing(true)
        let fontVC = FontViewController()
        fontVC.delegate = self
        show(fontVC, sender: nil)
    }
    
    @objc func onTextFiledTextDidChange(noti: Notification) {
        guard let sender = noti.object as? UITextView, sender == textView else {
            return
        }
        handleWhenTextDidChange(text: sender.text)
    }
    
    func performAttributedString(text: String?) -> NSAttributedString? {
        guard let text = text else {
            return nil
        }
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        if let font = performFont {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 0
            style.minimumLineHeight = font.lineHeight
            style.maximumLineHeight = font.lineHeight
            style.lineHeightMultiple = 1
//            style.alignment = .left
            style.lineBreakMode = .byWordWrapping
            style.lineSpacing = 0
            print("font: \(font.description) - leading: \(font.leading)")
            attributes[.font] = font
            attributes[.strokeWidth] = -2
            attributes[.strokeColor] = UIColor.white
            attributes[.foregroundColor] = UIColor.black
//            attributes[.backgroundColor] = UIColor.red
            attributes[.paragraphStyle] = style
        }
    
        let result = NSAttributedString(string: text, attributes: attributes)
        
        return result
    }
    
    func handleWhenTextDidChange(text: String?) {
        guard let attributedString = performAttributedString(text: text) else {
            imageView.image = nil
            return
        }
        textView.attributedText = attributedString
        let format = UIGraphicsImageRendererFormat.preferred()
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(bounds: imageView.bounds, format: format)
        imageView.image = renderer.image { rendererContext in
            textView.layer.render(in: rendererContext.cgContext)
        }
        if let imageData = imageView.image?.pngData() {
            UIPasteboard.general.setData(imageData, forPasteboardType: "public.png")
        }
    }
}
