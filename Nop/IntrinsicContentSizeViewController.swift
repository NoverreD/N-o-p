//
//  IntrinsicContentSizeViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/11/23.
//

import UIKit

class IntrinsicContentSizeViewController: UIViewController {
    
    var dataSource = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...50 {
            dataSource.append(Int.random(in: 1000...2000))
        }
        setupSubview()
        addLayout()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        temp.dataSource = self
        temp.backgroundColor = UIColor.brown
        return temp
    }()
    
    lazy var button: UIView = {
        let temp = UILabel()
        temp.text = "Add!!!"
//        temp.setTitle("Add!!!!", for: .normal)
        temp.backgroundColor = UIColor.red
        return temp
    }()
}

extension IntrinsicContentSizeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
        let labelTag = 22
        func fetchLabel(num: Int) -> UILabel {
            let temp = UILabel()
            temp.tag = labelTag
            temp.text = "\(num)"
            temp.textAlignment = .center
            temp.backgroundColor = UIColor.white
            return temp
        }
        if cell.contentView.viewWithTag(labelTag) == nil {
            cell.contentView.backgroundColor = UIColor.blue
            let label = fetchLabel(num: indexPath.row)
            cell.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

// MARK: - private function
extension IntrinsicContentSizeViewController {
    func setupSubview() {
        view.addSubview(collectionView)
        view.addSubview(button)
    }
    
    func addLayout() {
        collectionView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        button.snp.makeConstraints { make in
//            make.edges.equalTo(collectionView.contentLayoutGuide)
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.contentLayoutGuide.snp.bottom).offset(10)
        }
    }
}


