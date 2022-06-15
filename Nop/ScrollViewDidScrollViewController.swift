//
//  ScrollViewDidScrollViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/2/21.
//

import UIKit

class ScrollViewDidScrollViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 3)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }

    lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.delegate = self
        return temp
    }()

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}
