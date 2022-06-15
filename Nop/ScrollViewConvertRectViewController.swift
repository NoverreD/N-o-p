//
//  ScrollViewConvertRectViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/8/10.
//

import UIKit
import SnapKit

class ScrollViewConvertRectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        addLayout()
    }
    

    lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.delegate = self
        temp.minimumZoomScale = 1
        temp.maximumZoomScale = 10
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onScrollViewLongGestureRecognizer(gestureRecognizer:)))
        temp.addGestureRecognizer(longGestureRecognizer)
        return temp
    }()
    
    lazy var containerView: UIView = {
        let temp = UIView()
        return temp
    }()

    lazy var zoomImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "myImage-2")
        return temp
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame.size = CGSize(width: view.bounds.size.width * 2, height: view.bounds.height * 2)
        scrollView.contentSize = containerView.frame.size
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.setContentOffset(CGPoint(x: 100, y: 100), animated: false)
        } completion: { _ in
            print("2")
        }

    }

    @objc func onScrollViewLongGestureRecognizer (gestureRecognizer: UILongPressGestureRecognizer) {
        if let rect = zoomImageView.superview?.convert(zoomImageView.frame, to: view) {
            print("hao-1: --- \(rect)")
        }
        print("hao-2: \(scrollView.frame) \(scrollView.contentOffset)")
        let rect = zoomImageView.convert(scrollView.frame, from: scrollView.superview)
        print("hao-3: --- \(rect)")
        let rect2 = scrollView.convert(scrollView.bounds, to: zoomImageView)
        print("hao-4: --- \(rect2)")
        let temp = CGRect(x: rect.origin.x * scrollView.zoomScale,
               y: rect.origin.y * scrollView.zoomScale,
               width: rect.size.width * scrollView.zoomScale,
               height: rect.size.height * scrollView.zoomScale)
        print("hao-5: --- \(temp)")
    }
}

//MARK: - UIScrollViewDelegate
extension ScrollViewConvertRectViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
}

extension ScrollViewConvertRectViewController {
    func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(zoomImageView)
        zoomImageView.sizeToFit()
    }
    
    func addLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10))
        }
        
        zoomImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
