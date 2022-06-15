//
//  ShadowViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/4/1.
//

import UIKit

//


class ShadowViewController: UIViewController {
    
    struct Item {
        var tag: String
        var slider: UISlider
        var titleLabel: UILabel
        var valueLabel: UILabel
    }
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = ["color", "offsetW", "offsetH", "radius", "opacity"]
        let sliders = [shadowColorSlider, shadowOffsetWSlider, shadowOffsetHSlider, shadowRadiusSlider, shadowOpacitySlider]
        for index in 0..<titles.count {
            let tag = titles[index]
            let label = UILabel()
            label.text = titles[index]
            label.textAlignment = .left
            label.textColor = UIColor.randomColor
            label.backgroundColor = UIColor.randomColor

            let valueLabel = UILabel()
            valueLabel.textAlignment = .right
            valueLabel.textColor = UIColor.randomColor
            valueLabel.text = "00"
            valueLabel.backgroundColor = UIColor.randomColor
            items.append(Item(
                tag: tag,
                slider: sliders[index],
                titleLabel: label,
                valueLabel: valueLabel
            ))
        }
        setupSubview()
        addLayout()
    }
    
    
    @objc func onSlider(sender: UISlider) {
        let temp = items.first { i in
            return i.slider == sender
        }
        guard let item = temp else {
            return
        }
        item.valueLabel.text = "\(sender.value)"
        switch item.slider {
        case shadowColorSlider:
            shadowView.layer.shadowColor = UIColor.randomColor.cgColor
        case shadowOffsetHSlider:
            var shadowOffset = shadowView.layer.shadowOffset
            shadowOffset.height = CGFloat(sender.value)
            shadowView.layer.shadowOffset = shadowOffset
        case shadowOffsetWSlider:
            var shadowOffset = shadowView.layer.shadowOffset
            shadowOffset.width = CGFloat(sender.value)
            shadowView.layer.shadowOffset = shadowOffset
        case shadowRadiusSlider:
            shadowView.layer.shadowRadius = CGFloat(sender.value)
        case shadowOpacitySlider:
            shadowView.layer.shadowOpacity = Float(sender.value)
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shadowView.tag = shadowView.tag == 0 ? 1 : 0
        if shadowView.tag == 0 {
            contentImageView2.frame = CGRect(x: 20, y: 30, width: 40, height: 40)
            shadowView.addSubview(contentImageView2)
            shadowView.addSubview(contentImageView)
        } else {
            contentImageView2.removeFromSuperview()
            contentImageView.removeFromSuperview()
        }
//        shadowView.backgroundColor = shadowView.tag == 0 ? UIColor.red : UIColor.clear
    }

    
    lazy var shadowView: UIView = {
        let temp = UIView()
//        temp.backgroundColor = UIColor.red
        return temp
    }()
    
    lazy var contentImageView: UIImageView = {
        let ig = UIImageView(image: UIImage(named: "AppIcon"))
        ig.clipsToBounds = true
        ig.layer.cornerRadius = 10
        ig.tag = 11
        return ig
    }()
    
    lazy var contentImageView2: UIImageView = {
        let ig = UIImageView(image: UIImage(named: "AppIcon"))
        ig.clipsToBounds = true
        ig.layer.cornerRadius = 10
        ig.tag = 11
        return ig
    }()

    lazy var shadowColorSlider: UISlider = {
        let temp = UISlider()
        temp.addTarget(self, action: #selector(onSlider(sender: )), for: .valueChanged)
        return temp
    }()
    
    lazy var shadowOffsetHSlider: UISlider = {
        let temp = UISlider()
        temp.addTarget(self, action: #selector(onSlider(sender: )), for: .valueChanged)
        temp.maximumValue = 30
        temp.minimumValue = -30
        return temp
    }()
    
    lazy var shadowOffsetWSlider: UISlider = {
        let temp = UISlider()
        temp.addTarget(self, action: #selector(onSlider(sender: )), for: .valueChanged)
        temp.maximumValue = 30
        temp.minimumValue = -30
        return temp
    }()
    
    lazy var shadowRadiusSlider: UISlider = {
        let temp = UISlider()
        temp.addTarget(self, action: #selector(onSlider(sender: )), for: .valueChanged)
        temp.maximumValue = 50
        temp.minimumValue = 0
        return temp
    }()
    
    lazy var shadowOpacitySlider: UISlider = {
        let temp = UISlider()
        temp.addTarget(self, action: #selector(onSlider(sender: )), for: .valueChanged)
        temp.maximumValue = 1
        temp.minimumValue = 0
        return temp
    }()
}

extension ShadowViewController {
    private func setupSubview() {
        view.addSubview(shadowView)
        for (_, item) in items.enumerated() {
            view.addSubview(item.titleLabel)
            view.addSubview(item.slider)
            view.addSubview(item.valueLabel)
        }
    }
    
    private func addLayout() {
        shadowView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 101, height: 101))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        var lastView = shadowView
        for item in items {
            item.titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalTo(lastView.snp.bottom).offset(10)
                make.width.equalTo(80)
            }
            item.slider.snp.makeConstraints { make in
                make.left.equalTo(item.titleLabel.snp.right).offset(8)
                make.centerY.equalTo(item.titleLabel)
            }
            item.valueLabel.snp.makeConstraints { make in
                make.left.equalTo(item.slider.snp.right).offset(8)
                make.centerY.equalTo(item.slider)
                make.right.equalToSuperview()
                make.width.equalTo(60)
            }

            lastView = item.titleLabel
        }
    }
}
