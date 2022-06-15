//
//  ImagePickerViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/8/30.
//

import UIKit

class ImagePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
    
    lazy var button: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = UIColor.yellow
        temp.setTitle("abc", for: .normal)
        temp.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
        return temp
    }()

    @objc func onButton(sender: Any) {
        let vc = UIImagePickerController()
        vc.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let vc = EmptyViewController()
//        vc.view.backgroundColor = UIColor.red
//        picker.present(vc, animated: true, completion: nil)

    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print(viewController.view)
        print("\(#function) \(viewController)")
    }
}


private class EmptyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }

    lazy var button: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = UIColor.yellow
        temp.setTitle("kkk", for: .normal)
        temp.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
        return temp
    }()

    @objc func onButton(sender: Any) {
        if navigationController != nil {
            navigationController?.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

private class MyImagePickerViewController: UIImagePickerController {
    override var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? {
        get {
            return super.delegate
        }
        set {
            super.delegate = newValue
        }
    }
}
