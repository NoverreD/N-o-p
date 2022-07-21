//
//  CollectionReusableView.swift
//  Nop
//
//  Created by dengzhihao on 2022/7/20.
//

import UIKit

class CollectionSectionHeaderReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderCollectionViewFlowLayoutAttributes: UICollectionViewLayoutAttributes {
    var contentView: UIView?
    var backgroundColor: UIColor?
}

class HeaderFlowLayoutEntryView: UICollectionReusableView {
    private var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("hao - HomePageFoldEntryReusableView.init")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let temp = layoutAttributes as? HeaderCollectionViewFlowLayoutAttributes else {
            return
        }
        if temp.contentView != contentView {
            contentView?.removeFromSuperview()
            contentView = nil
        }
        
        if let aView = temp.contentView {
            contentView = aView
            addSubview(aView)
        }
        backgroundColor = temp.backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
