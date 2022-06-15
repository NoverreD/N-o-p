//
//  CVLayoutViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/18.
//

import UIKit

class CVLayoutViewController: UIViewController {

    var dataSource: [(width: Int,bgColor: UIColor)] = []
    
    static let cellReuseIdentifier = "CVLayoutViewController.UICollectionViewCell.ReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectView)
        for _ in 0...40 {
            dataSource.append((Int.random(in: 40...300), UIColor.randomColor))
        }
        collectView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

    lazy var collectView: UICollectionView = {
        let layout = MyCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        let temp = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        temp.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
        temp.dataSource = self
        temp.delegate = self
        temp.backgroundColor = UIColor.white
        return temp
    }()
}

extension CVLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellReuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = dataSource[indexPath.row].bgColor
        return cell
    }
}

extension CVLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dataSource[indexPath.item].width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

class MyCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let result = super.layoutAttributesForElements(in: rect) , rect.origin.x == 0 else {
            return nil
        }
        
        var markRect: CGRect?
        
        for aLayoutAttributes in result {
            let indexPath = aLayoutAttributes.indexPath
            let minMarkX = rect.minX + sectionInset(forSectionAt: indexPath.section).left
            if let tempRect = markRect {
                if tempRect.origin.y != aLayoutAttributes.frame.origin.y {
                    aLayoutAttributes.frame.origin.x = minMarkX
                } else {
                    aLayoutAttributes.frame.origin.x = tempRect.maxX + interitemSpacing(forSectionAt: indexPath.section)
                }
            } else {
                aLayoutAttributes.frame.origin.x = minMarkX
            }
            markRect = aLayoutAttributes.frame
        }
        
        return result
    }
    
    private func sectionInset(forSectionAt section: Int) -> UIEdgeInsets {
        guard let collectionView = collectionView, let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            return sectionInset
        }
        return delegate.collectionView?(collectionView, layout: self, insetForSectionAt: section) ?? sectionInset
    }
    
    private func interitemSpacing(forSectionAt section: Int) -> CGFloat {
        guard let collectionView = collectionView, let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            return minimumInteritemSpacing
        }
        return delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
    }
}
