//
//  CIViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/6/27.
//

import UIKit
import CoreImage
import Photos

class CIViewController: UIViewController {
    
    let filters = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone",
        "CIThermal",
        "CIVignetteEffect"
    ]
    
    let context = CIContext(options: nil)
    
    let myImage = UIImage(named: "myImage")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width-40
        guard let size = imageView.image?.size else {
            return
        }
        
        let height = size.height/size.width * width
        
        imageView.frame = CGRect(x: 20, y: 50, width: width, height: height)

    }
    
    var index = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ciImage = CIImage(image: myImage)!
        let filterName = filters[index]
        index += 1
        index = index % (filters.count-1)
        let localName = CIFilter.localizedName(forFilterName: filterName) ?? ""
        print("filter: \(filterName), localName: \(localName),index = \(index), count = \(filters.count)")
        let filter = CIFilter(name: filterName, parameters: [
            kCIInputImageKey: ciImage
        ])
        filter?.setDefaults()
        guard let outImage = filter?.outputImage,
              let cgImage = context.createCGImage(outImage, from: outImage.extent) else {
            return
        }
        imageView.image = UIImage(cgImage: cgImage)
    }


    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.image = myImage
        temp.sizeToFit()
        return temp
    }()
}
