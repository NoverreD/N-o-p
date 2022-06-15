//
//  KeyboardViewController4.swift
//  NopKB
//
//  Created by dengzhihao on 2022/2/21.
//

import UIKit

class KeyboardViewController4: UIInputViewController {

    var dataSouce = 20
    
    var ed = UIEdgeInsets.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        let viewHeigthConstraint = view.heightAnchor.constraint(equalToConstant: 300)
        viewHeigthConstraint.priority = UILayoutPriority(999)
        viewHeigthConstraint.isActive = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: 200, height: view.bounds.height)
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        temp.dataSource = self
        temp.delegate = self
        temp.backgroundColor = UIColor.red
        return temp
    }()
}

extension KeyboardViewController4: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        print("\(#function)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(#function)")
        return dataSouce
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let l = collectionView.bounds.width / 3 - 10
        print("\(#function)")
        return CGSize(width: l, height: collectionView.bounds.height / 2.0 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(#function)")
        if indexPath.row == 0 {
            ed = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            ed = .zero
        }
        view.setNeedsLayout()
    }
    
}


private class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutInvalidationContext = context as? UICollectionViewFlowLayoutInvalidationContext,
              shouldInvalidateLayout(forBoundsChange: newBounds) else {
            return context
        }
        flowLayoutInvalidationContext.invalidateFlowLayoutDelegateMetrics = true
        return flowLayoutInvalidationContext
    }
}
