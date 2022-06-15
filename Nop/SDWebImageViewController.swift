//
//  SDWebImageViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/25.
//

import UIKit
import SnapKit
import SDWebImage

class SDWebImageViewController: UIViewController {
    let imageUrl = URL(string: "https://d2nmg3qradgpe0.cloudfront.net/cdn-inner/simeji-switch-font/icon/ゆるい系.png".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubview()
        addLayout()
    }
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.red
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: []) { image, _, _, _ in
            self.imageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
}

extension SDWebImageViewController {
    func setupSubview() {
        view.addSubview(imageView)
        imageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
    func addLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
    }
}
