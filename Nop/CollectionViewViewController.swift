//
//  CollectionViewViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/23.
//

import UIKit

class CollectionViewViewController: UIViewController {

    var needUpdate = false
    
    var currentIndex: IndexPath?
    
    var edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds.inset(by: edgeInsets)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        collectionView.reloadData()
        edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    static let cellReuseIdentifier = "cell.identifier.\(UICollectionViewCell.self)"
    static let scCellReuseIdentifier = "svcell.identifier.\(SvCollectionViewCell.self)"
    static let footerReuseIdentifier = "footer.identifier.\(UICollectionViewCell.self)"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let temp = MyCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        temp.register(MyCollectionViewCell2.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
        temp.register(SvCollectionViewCell.self, forCellWithReuseIdentifier: Self.scCellReuseIdentifier)
        temp.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.footerReuseIdentifier)
        temp.delegate = self
        temp.dataSource = self
        temp.backgroundColor = UIColor.blue
        return temp
    }()

    
    var simpleDataSoure = [
        [1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4],
        [11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14]
    ]
    
    var itemSize: CGSize = CGSize(width: 80, height: 80)
    var sectionInsets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
    var sectionFooterSize = CGSize(width: 0, height: 50)

}

extension CollectionViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simpleDataSoure[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0, indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.scCellReuseIdentifier, for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellReuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.red
        cell.contentView.backgroundColor = currentIndex == indexPath ? UIColor.green : UIColor.red
        print("\(#function)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let viewForSupplementary = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.footerReuseIdentifier, for: indexPath)
        viewForSupplementary.backgroundColor = UIColor.yellow
        viewForSupplementary.isHidden = sectionFooterSize.height <= 0
        return viewForSupplementary
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return simpleDataSoure.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return sectionFooterSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.contentView.backgroundColor = UIColor.green
        currentIndex = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.contentView.backgroundColor = UIColor.red
    }
}

extension CollectionViewViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0, indexPath.section == 0 {
//            return CGSize(width: itemSize.width * 2, height: itemSize.height)
//        }
        print("\(#function)")
        return CGSize(width: collectionView.bounds.width / 4.0, height: collectionView.bounds.width / 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if needUpdate {
            collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 1))?.isHidden = true
            collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
    
}


class SvCollectionViewCell: UICollectionViewCell {
    lazy var scrollView: UIScrollView = {
        let temp = MyScrollView()
        temp.delaysContentTouches = false
//        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.text = "asdfasdf"
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollView)
        label.sizeToFit()
        scrollView.addSubview(label)
        label.frame = CGRect(x: 4, y: 4, width: label.frame.size.width, height: label.frame.size.height)
        scrollView.contentSize = CGSize(width: label.frame.width * 3, height: 80)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        if result == scrollView {
            return self
        }
        return result
    }
    
}

class MyCollectionViewCell2: UICollectionViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}


class MyScrollView: UIScrollView {
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        return true
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

class MyCollectionView: UICollectionView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}
