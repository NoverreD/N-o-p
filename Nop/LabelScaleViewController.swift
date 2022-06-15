//
//  LabelScaleViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/11/16.
//

import UIKit

class LabelScaleViewController: UIViewController {
    private var performFont: UIFont? = UIFont.systemFont(ofSize: 35, weight: .heavy)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        NotificationCenter.default.addObserver(self, selector: #selector(onTextDidChange(noti:)), name: UITextView.textDidChangeNotification, object: textView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var markY: CGFloat = 100
        imageView.frame = CGRect(x: 8, y: markY, width: view.bounds.width-16, height: view.bounds.width-16)
        markY = imageView.frame.maxY + 20
        textView.frame = CGRect(x: 10, y: markY, width: view.bounds.width-16, height: view.bounds.width-16)
    }
    
    @objc func onTextDidChange(noti: Notification) {
        guard let sender = noti.object as? UITextView, sender == textView else {
            return
        }
        handleWhenTextDidChange(text: sender.text)
    }
    
    func handleWhenTextDidChange(text: String?) {
        guard let attributedString = performAttributedString(text: text) else {
            imageView.image = nil
            return
        }
        textView.attributedText = attributedString
        let format = UIGraphicsImageRendererFormat.preferred()
        format.opaque = false
        format.scale = 10
        let renderer = UIGraphicsImageRenderer(bounds: imageView.bounds, format: format)
        imageView.image = renderer.image { rendererContext in
            textView.layer.render(in: rendererContext.cgContext)
        }
        if let imageData = imageView.image?.pngData() {
            UIPasteboard.general.setData(imageData, forPasteboardType: "public.png")
        }
    }
    
    func performAttributedString(text: String?) -> NSAttributedString? {
        guard let text = text else {
            return nil
        }
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        if let font = textView.font {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 0
            style.minimumLineHeight = font.lineHeight
            style.maximumLineHeight = font.lineHeight
            style.lineHeightMultiple = 1
            style.alignment = .left
            style.lineBreakMode = .byWordWrapping
            style.lineSpacing = 0
            attributes[.font] = font
            attributes[.strokeWidth] = -2
            attributes[.strokeColor] = UIColor.white
            attributes[.foregroundColor] = UIColor.black
            attributes[.backgroundColor] = UIColor.red
            attributes[.paragraphStyle] = style
        }
    
        let result = NSAttributedString(string: text, attributes: attributes)
        
        return result
    }
    
    func setupSubview() {
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
        view.addSubview(textView)
    }

    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.white
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.black.cgColor
        temp.layer.cornerRadius = 1
        temp.contentMode = .center
        return temp
    }()
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.textContainer.lineFragmentPadding = 0
        temp.layoutManager.usesFontLeading = false
        temp.backgroundColor = nil
        return temp
    }()
}
