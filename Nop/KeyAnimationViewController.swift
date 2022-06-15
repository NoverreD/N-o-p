//
//  KeyAnimationViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/18.
//

import UIKit

class KeyAnimationViewController: UIViewController, CAAnimationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
    }

    lazy var imageView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        temp.image = UIImage(named: "AppIcon")
        temp.isUserInteractionEnabled = true
        temp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(sender:))))
        return temp
    }()
    
    lazy var imageView2: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
        temp.image = UIImage(named: "AppIcon")
        temp.isUserInteractionEnabled = true
        temp.tag = 1
        temp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(sender:))))
        return temp
    }()
    
    lazy var imageView3: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 100, y: 400, width: 50, height: 50))
        temp.image = UIImage(named: "AppIcon")
        temp.isUserInteractionEnabled = true
        temp.tag = 2
        temp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(sender:))))
        return temp
    }()
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else {
            return
        }
        if senderView.tag == 0 {
            startScaleAnimation(senderView, scaleFactor: 1.2)
        } else if senderView.tag == 1 {
            startScaleAnimation2(senderView, scaleFactor: 1.2)
        } else if senderView.tag == 2 {
            startScaleAnimation3(senderView, scaleFactor: 1.2)
        }
    }
    
    /// 呼吸动效重复2次
    private func startScaleAnimation(_ animateImageView: UIView, scaleFactor: CGFloat, completion: ((Bool) -> Void)? = nil) {
        let duration = 0.65
        let originScale = CGFloat(1.0)
                
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction) {
            animateImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        } completion: { _ in
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction) {
                animateImageView.transform = CGAffineTransform(scaleX: originScale, y: originScale)
            } completion: { _ in
                UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction) {
                    animateImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                } completion: { _ in
                    UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                        animateImageView.transform = CGAffineTransform(scaleX: originScale, y: originScale)
                    }, completion: completion)
                }
            }
        }
    }
    
    private func startScaleAnimation2(_ animateImageView: UIView, scaleFactor: CGFloat, completion: ((Bool) -> Void)? = nil) {
        let duration = 0.65
                
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform")

        scaleAnimation.values = [
            CATransform3DIdentity,
            CATransform3DMakeScale(scaleFactor, scaleFactor, 1),
            CATransform3DIdentity,
            CATransform3DMakeScale(scaleFactor, scaleFactor, 1),
            CATransform3DIdentity
        ]
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.duration = duration * 4
        scaleAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animateImageView.layer.add(scaleAnimation, forKey: nil)
        animateImageView.layer.setValue(completion, forKey: "completion.block")
        scaleAnimation.delegate = self
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            (anim.value(forKey: "completion.block") as? ((Bool)->Void))?(true)
        }
    }

    private func startScaleAnimation3(_ animateImageView: UIView, scaleFactor: CGFloat, completion: ((Bool) -> Void)? = nil) {
        let duration = 0.65
        UIView.animateKeyframes(withDuration: duration * 4, delay: 0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                animateImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                animateImageView.transform = CGAffineTransform.identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                animateImageView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                animateImageView.transform = CGAffineTransform.identity
            }
        }, completion: completion)
    }
    
}
