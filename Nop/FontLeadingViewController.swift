//
//  FontLeadingViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/2/25.
//

import UIKit
import SnapKit

class FontLeadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelForText)
        view.addSubview(borderView1)
        view.addSubview(labelForAttributedText)
        view.addSubview(borderView2)
        view.addSubview(textView)
        addLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        labelForText.frame = CGRect(x: 8, y: 100, width: labelWidth, height: 200)
        
        labelForAttributedText.frame = CGRect(origin: CGPoint(x: labelForText.frame.minX,
                                                              y: labelForText.frame.maxY + 50),
                                              size: labelForText.frame.size)
        
        textView.frame = CGRect(origin: CGPoint(x: labelForAttributedText.frame.minX,
                                                y: labelForAttributedText.frame.maxY + 50),
                                size: labelForAttributedText.frame.size)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let textHeight = getTextSizeWithSizeThatFits(label: labelForText).height
        borderView1.snp.updateConstraints { make in
            make.height.equalTo(textHeight)
        }
        
        
        let textHeight2 = getTextSizeWithBoundingRect(attText: labelForAttributedText.attributedText!,
                                                      options: [.usesLineFragmentOrigin]).height
        borderView2.snp.updateConstraints { make in
            make.height.equalTo(textHeight2)
        }
    }
    
    private func getTextSizeWithSizeThatFits(label: UILabel) -> CGSize {
        let rulerSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let size = label.sizeThatFits(rulerSize)
        return size
    }
    
    private func getTextSizeWithBoundingRect(attText: NSAttributedString,
                                             options: NSStringDrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        let rulerSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        var size = attText.boundingRect(with: rulerSize,
                                     options: options,
                                     context: nil).size
        size.height += abs(textFont.leading)
        return size
    }
    
    func fetchText() -> String {
        let text = "jjjj👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👔🙂💽😉⌨️😌🙃ンキーな愛jjj😜🙂😉😌🙃😜🙂😉ンキーな愛😌🙃😜ヤンキーな愛情🙂😉😜か～？？CP名🙂😉😌🙃😜ンキーな愛🙂😉😌🙃jj"
//        let text = "jjjjjjjjjjjjjjjjjjjjjjpqpqqpqpqpqpjpppjjjjjjjjjjjjjjjjjjjjjjpqpqqpqpqpqpjpppjjjjjjjjjjjjjjjjjjjjjjpqpqqpqpqpqpjpppjjjjjjjjjjjjjjjjjjjjjjpqpqqpqpqpqpjpppjjjjjjjjjjjjjjjjjjjjjjpqpqqpqpqpqpjppp"
//        let text = "jjjjj"
//        let text = "👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦jlkhh=哼唧唧👔"
        return text
    }
    
    func fetchAttributedText() -> NSAttributedString {
        let text = fetchText()
        let font = textFont// UIFont.systemFont(ofSize: 17)
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping
        style.lineSpacing = 3
        let attributeText = NSAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.font: font,
                                                            NSAttributedString.Key.foregroundColor: UIColor.black,
                                                            NSAttributedString.Key.backgroundColor: UIColor.red.withAlphaComponent(0.5),
                                                            .paragraphStyle: style])
        return attributeText
    }
    
    private func addLayout() {
        borderView1.snp.makeConstraints { make in
            make.right.left.centerY.equalTo(labelForText)
            make.height.equalTo(0)
        }

        borderView2.snp.makeConstraints { make in
            make.right.left.centerY.equalTo(labelForAttributedText)
            make.height.equalTo(0)
        }
    }
    
    private var labelWidth: CGFloat {
        return view.bounds.width - 16
    }
    
    private var textFont: UIFont {
        return UIFont(name: "MyanmarSangamMN", size: 17)!
//        return UIFont(name: "HiraKakuProN-W3", size: 10)!
//        return UIFont.systemFont(ofSize: 17)
    }

    lazy var labelForText: UILabel = {
        let temp = UILabel()
        temp.text = fetchText()
        temp.backgroundColor = UIColor.blue
        temp.numberOfLines = 0
        temp.font = textFont
        temp.baselineAdjustment = .none
        return temp
    }()

    lazy var labelForAttributedText: UILabel = {
        let temp = UILabel()
        temp.attributedText = fetchAttributedText()
        temp.backgroundColor = UIColor.gray
        temp.numberOfLines = 0
        temp.baselineAdjustment = .none
        return temp
    }()
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.text = fetchText()
        temp.backgroundColor = UIColor.cyan
        temp.font = textFont
        return temp
    }()
    
    lazy var borderView1: UIView = {
        let temp = UIView()
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.yellow.cgColor
        return temp
    }()
    
    lazy var borderView2: UIView = {
        let temp = UIView()
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.yellow.cgColor
        return temp
    }()
}
