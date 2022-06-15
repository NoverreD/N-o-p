//
//  LabelContainerViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/7/22.
//

import UIKit
import SnapKit

class LabelContainerViewController: UIViewController {

    let titles = [
        "中",
        "中",
        "中",
        "中中中中中中中中",
        "中",
        "中中中中",
        "中中",
        "中中中中中中",
        "中中",
        "中中中中中中",
        "中中中中中中",
        "中中中中中中",
        "中中中中中中",
        "中中中中中中",
        "中中中中中中"
    ]
    
    static let minimumWidth: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let label = labels[2]
//        label.text = label.text?.appending("中")
    }

    lazy var labels: [UIView] = {
        var result: [UIView] = []
        for title in titles {
            result.append({
                let temp = MyButton()
                temp.setTitle(title, for: .normal)
                temp.backgroundColor = UIColor.randomColor
                return temp
            }())
        }
        return result
    }()
    
    lazy var containerView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.blue
        return temp
    }()
    
    lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.backgroundColor = UIColor.randomColor
        temp.isDirectionalLockEnabled = true
        temp.contentInsetAdjustmentBehavior = .never
        return temp
    }()
}

extension LabelContainerViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        for label in labels {
            containerView.addSubview(label)
        }
    }
    
    func setupLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
        }
        
        var lastLabel: UIView?
        for label in labels {
            label.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.greaterThanOrEqualTo(Self.minimumWidth)
                make.width.greaterThanOrEqualTo(scrollView).multipliedBy(1 / CGFloat(labels.count))

                if let lastLabel = lastLabel {
                    make.left.equalTo(lastLabel.snp.right)
                } else {
                    make.left.equalToSuperview()
                }
            }
            lastLabel = label
        }
        if let lastLabel = lastLabel {
            lastLabel.snp.makeConstraints { make in
                make.right.equalToSuperview()
            }
        }
    }
}

extension UIColor {
    static var randomColor: UIColor {
        get {
            let red = CGFloat.random(in: 0...1)
             let green = CGFloat.random(in: 0...1)
             let blue = CGFloat.random(in: 0...1)
             return UIColor (red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

class MyLabel: UILabel {
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var result = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        result.size.width += 20
        return result
    }
}


private class MyButton: UIButton {
    override var intrinsicContentSize: CGSize {
        var result = super.intrinsicContentSize
        result.width += 10
        return result
    }
}
