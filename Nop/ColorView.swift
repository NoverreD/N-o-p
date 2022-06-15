//
//  ColorView.swift
//  Nop
//
//  Created by dengzhihao on 2021/6/27.
//

import UIKit

class ColorView: UIView {
    
    deinit {
        print("deinit \(self)")
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initGradientLayer()
    }
    
    func initGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.type = CAGradientLayerType.axial
        gradientLayer.colors = colors.map({ color in
            return color.cgColor
        })
        gradientLayer.borderColor = UIColor.gray.cgColor
        gradientLayer.borderWidth = 0.2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.cornerRadius = bounds.height / 2.0
    }
    
    func color(point: CGPoint) -> UIColor {
        var index = lround(Double(point.x / bounds.width) * Double(colors.count))
        index = min(colors.count - 1, index)
        index = max(0, index)
        return colors[index]
    }
    
    lazy private(set) var colors: [UIColor] = {
        let helper = ColorsHelper()
        return helper.colors()
    }()

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
}

struct WhiteColorsHelper {
    var count: Int = 1000
    
    func colors() -> [UIColor] {
        var result: [UIColor] = []
        
        for step in 0..<count {
            let brightness = 1.0 / CGFloat(count) * CGFloat(step+1)
            let color = UIColor(hue: 1, saturation: 0, brightness: 1-brightness, alpha: 1)
            result.append(color)
        }
        return result
    }
}

struct AlphaWhiteColorHelper {
    var count: Int = 9
    
    func colors() -> [UIColor] {
        var result: [UIColor] = []
        
        for step in 0..<count {
            let white = 1.0 / CGFloat(count) * CGFloat(step)
            let color = UIColor(white: 1-white, alpha: 1)
            result.append(color)
        }
        return result
    }
}


struct ColorsHelper {
    var count: Int = 10
    var breakPoint: CGFloat = 0.15
    var whitePoint: CGFloat = 0.05
    
    func colors() -> [UIColor] {
        var result: [UIColor] = []
        
        let breakStepCount = CGFloat(count) * breakPoint
        
        let saturationStepValue = 1 / breakStepCount
        
        for step in 0..<count {
            let hue = 1.0 / CGFloat(count) * CGFloat(step+1) - breakPoint
            let saturation: CGFloat = hue > 0 ? 1 : (CGFloat(step) * saturationStepValue)
            let color = UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1)
            result.append(color)
        }
        
        let whiteCount = Int(CGFloat(count) * whitePoint)
        
        for _ in 0..<whiteCount {
            result.insert(UIColor.white, at: 0)
        }
        return result
    }
}
