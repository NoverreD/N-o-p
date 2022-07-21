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
    static let sectionReuseIdentifier = "CVLayoutViewController.SectionHeader.ReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectView)
        for _ in 0...240 {
            dataSource.append((100, UIColor.randomColor))
        }
        collectView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

    lazy var collectView: UICollectionView = {
        let layout = CollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.registerExtendDecorationView(CollectionExtendReusableView.self)
        layout.registerFoldDecorationView(CollectionFoldReusableView.self)
        layout.sectionHeadersPinToVisibleBounds = true
        let temp = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        temp.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
        temp.register(CollectionSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.sectionReuseIdentifier)
        temp.dataSource = self
        temp.delegate = self
        temp.backgroundColor = UIColor.white
        return temp
    }()
}

extension CVLayoutViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellReuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = dataSource[indexPath.row].bgColor
        (cell as? LabelCollectionViewCell)?.label.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let temp = collectionView.collectionViewLayout as? CollectionViewFlowLayout {
            let style: CollectionViewFlowLayout.HeaderStyle = temp.currentStyle == .extend ? .fold : .extend
            temp.updateStyleIfNeed(style)
        }
    }
}

extension CVLayoutViewController: CollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dataSource[indexPath.item].width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.sectionReuseIdentifier,
                                                               for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionViewFlowLayout(_ layout: CollectionViewFlowLayout, headerHeightForStyle style: CollectionViewFlowLayout.HeaderStyle) -> CGFloat {
        switch style {
        case .fold:
            return 50
        case .extend:
            return 200
        }
    }
}

class LabelCollectionViewCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = .clear
        temp.textAlignment = .center
        temp.textColor = .black
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}

class MyCollectionViewFlowLayout2: UICollectionViewFlowLayout {
    
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
