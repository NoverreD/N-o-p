//
//  CVCellSizeViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/2/18.
//

import UIKit

class CVCellSizeViewController: UIViewController {

    var dataSouce = 20
    
    var ed = UIEdgeInsets.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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

extension CVCellSizeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let l = collectionView.bounds.width / 3 - 10
        print("\(#function)")
        return CGSize(width: l, height: collectionView.bounds.height / 2.0 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            collectionView.frame = CGRect(x: 0, y: 0, width: 200, height: view.bounds.height)
//            ed = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            collectionView.frame = CGRect(x: 0, y: 0, width: 300, height: view.bounds.height - 10)
//            ed = .zero
        }
//        view.setNeedsLayout()
    }
    
}

private class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutInvalidationContext = context as? UICollectionViewFlowLayoutInvalidationContext,
              let cv = collectionView else {
            return context
        }
        flowLayoutInvalidationContext.invalidateFlowLayoutDelegateMetrics = cv.bounds.size != newBounds.size
        return flowLayoutInvalidationContext
    }
    
//    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
//        let context = super.invalidationContext(forBoundsChange: newBounds)
//        if let flowLayoutInvalidationContext = context as? UICollectionViewFlowLayoutInvalidationContext {
//            print(flowLayoutInvalidationContext.invalidateFlowLayoutAttributes)
//            print(flowLayoutInvalidationContext.invalidateFlowLayoutDelegateMetrics)
//        }
//        print("\(#function) - \(context)")
//        return context
//    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        let result = super.shouldInvalidateLayout(forBoundsChange: newBounds)
//        print("\(#function) - \(result)")
//        return result
//    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        guard let collectionView = collectionView else { return false }
//        return !newBounds.size.equalTo(collectionView.bounds.size)
//    }
}
