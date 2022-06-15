//
//  GifImageViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/12/20.
//

import UIKit
import SDWebImage
// https://bestanimations.com/Animals/Mammals/Cats/catart/animated-cat-art-gif-13.gif
class GifImageViewController: UIViewController {
    
    let gifUrl = URL(string: "https://bestanimations.com/Animals/Mammals/Cats/catart/animated-cat-art-gif-13.gif")
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageView.sd_setImage(with: gifUrl) { image, error, type, _ in
            if let error = error {
                print(error.localizedDescription)
            }
            print(type)
        }
    }
}
