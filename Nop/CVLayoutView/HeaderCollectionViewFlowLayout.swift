//
//  HeaderCollectionViewFlowLayout.swift
//
//  Created by dengzhihao on 2022/7/20.
//

import UIKit

protocol HeaderCollectionViewFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func headerCollectionViewFlowLayout(_ layout: HeaderCollectionViewFlowLayout,
                                  headerHeightForStyle style: HeaderCollectionViewFlowLayout.HeaderStyle) -> CGFloat
    func headerCollectionViewFlowLayout(_ layout: HeaderCollectionViewFlowLayout,
                                  contentViewForStyle style: HeaderCollectionViewFlowLayout.HeaderStyle) -> UIView?
}

extension HeaderCollectionViewFlowLayoutDelegate {
    func headerCollectionViewFlowLayout(_ layout: HeaderCollectionViewFlowLayout,
                                        headerHeightForStyle style: HeaderCollectionViewFlowLayout.HeaderStyle) -> CGFloat {
        return 0
    }
    
    func headerCollectionViewFlowLayout(_ layout: HeaderCollectionViewFlowLayout,
                                        contentViewForStyle style: HeaderCollectionViewFlowLayout.HeaderStyle) -> UIView? {
        return nil
    }
}

class HeaderCollectionViewFlowLayout: UICollectionViewFlowLayout {
    enum HeaderStyle {
        case extend
        case fold
        var elementKindString: String {
            switch self {
            case .extend:
                return "extend.elementKindString.HeaderStyle.HeaderCollectionViewFlowLayout.MusicTabComponent"
            case .fold:
                return "fold.elementKindString.HeaderStyle.HeaderCollectionViewFlowLayout.MusicTabComponent"
            }
        }
    }
    
    private(set) var currentStyle: HeaderStyle = .extend

    func updateStyle(_ style: HeaderStyle) {
        currentStyle = style
        invalidateLayout()
    }
    
    func updateStyleIfNeed(_ style: HeaderStyle) {
        if currentStyle != style {
            updateStyle(style)
        }
    }
    
    override func prepare() {
        super.prepare()
        registerFoldDecorationView(HeaderFlowLayoutEntryView.self)
        registerExtendDecorationView(HeaderFlowLayoutEntryView.self)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return HeaderCollectionViewFlowLayoutAttributes.classForCoder()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let todoRect = rect.insetBy(dx: 0, dy: -headerHeight(for: currentStyle))
        let originLayoutArrtibutes = super.layoutAttributesForElements(in: todoRect)
        guard var originLayoutArrtibutes = originLayoutArrtibutes else {
            return nil
        }
        for (index, attributes) in originLayoutArrtibutes.reversed().enumerated() {
            switch attributes.representedElementCategory {
            case .cell:
                if let temp = layoutAttributesForItem(at: attributes.indexPath) {
                    originLayoutArrtibutes[index] = temp
                }
            case .supplementaryView:
                if let representedElementKind = attributes.representedElementKind,
                   let temp = layoutAttributesForSupplementaryView(ofKind: representedElementKind, at: attributes.indexPath) {
                    originLayoutArrtibutes[index] = temp
                }
            case .decorationView:
                if let representedElementKind = attributes.representedElementKind {
                    if [HeaderStyle.fold.elementKindString, HeaderStyle.extend.elementKindString].contains(representedElementKind) {
                        originLayoutArrtibutes.remove(at: index)
                    } else if let temp = layoutAttributesForDecorationView(ofKind: representedElementKind, at: attributes.indexPath) {
                        originLayoutArrtibutes[index] = temp
                    }
                }
            default:
                break
            }
        }
        if let temp = layoutAttributesForDecorationView(ofKind: currentStyle.elementKindString, at: .holder) {
            originLayoutArrtibutes.append(temp)
        }
        return originLayoutArrtibutes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case HeaderStyle.extend.elementKindString:
            let attributes = HeaderCollectionViewFlowLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
            attributes.frame = CGRect(x: 0, y: 0, width: collectionViewContentSize.width, height: headerHeight(for: .extend))
            attributes.zIndex = .max - 10
            attributes.alpha = currentStyle == .extend ? 1 : 0
            attributes.contentView = delegate?.headerCollectionViewFlowLayout(self, contentViewForStyle: .extend)
            return attributes
        case HeaderStyle.fold.elementKindString:
            let attributes = HeaderCollectionViewFlowLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
            attributes.frame = CGRect(x: 0, y: max(0, collectionView?.contentOffset.y ?? 0), width: collectionViewContentSize.width, height: headerHeight(for: .fold))
            attributes.zIndex = .max
            attributes.alpha = currentStyle == .fold ? 1 : 0
            attributes.contentView = delegate?.headerCollectionViewFlowLayout(self, contentViewForStyle: .fold)
            return attributes
        default:
            return nil
        }
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if originalAttributes.representedElementCategory == .decorationView {
            return true
        }
        return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let result = super.invalidationContext(forBoundsChange: newBounds)
        result.invalidateDecorationElements(ofKind: HeaderStyle.fold.elementKindString, at: [.holder])
        result.invalidateDecorationElements(ofKind: HeaderStyle.extend.elementKindString, at: [.holder])
        if let temp = result as? UICollectionViewFlowLayoutInvalidationContext {
            temp.invalidateFlowLayoutAttributes = true
            temp.invalidateFlowLayoutDelegateMetrics = false
        }
        if currentStyle == .extend, newBounds.origin.y >= (headerDiffHeight) {
            currentStyle = .fold
            invalidateLayout()
            result.contentOffsetAdjustment = CGPoint(x: 0, y: -newBounds.origin.y)
            result.contentSizeAdjustment = CGSize(width: 0, height: headerDiffHeight)
        }
        return result
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let originArrtibutes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)?.copyAttributes
        if currentStyle == .extend {
            originArrtibutes?.frame.origin.y += max(headerHeight(for: .fold), (headerHeight(for: .extend) - max(0, collectionView?.bounds.origin.y ?? 0)))
        } else {
            originArrtibutes?.frame.origin.y += headerHeight(for: currentStyle)
        }
        return originArrtibutes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let originAttributes = super.layoutAttributesForItem(at: indexPath)?.copyAttributes
        originAttributes?.frame.origin.y += headerHeight(for: currentStyle)
        return originAttributes
    }

    override func initialLayoutAttributesForAppearingDecorationElement(ofKind elementKind: String, at decorationIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("\(#function)")
        let originAttributes = layoutAttributesForDecorationView(ofKind: elementKind, at: decorationIndexPath)?.copyAttributes
        originAttributes?.alpha = 0
        return originAttributes
    }

    override func finalLayoutAttributesForDisappearingDecorationElement(ofKind elementKind: String, at decorationIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("\(#function)")
        let originAttributes = layoutAttributesForDecorationView(ofKind: elementKind, at: decorationIndexPath)?.copyAttributes
        originAttributes?.alpha = 0
        return originAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var result = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        if currentStyle == .extend, (result.y < headerHeight(for: .extend) && result.y > 0 ){
            result.y = headerDiffHeight + 0.1
        }
        return result
    }
    
    override var collectionViewContentSize: CGSize {
        var result = super.collectionViewContentSize
        result.height += headerHeight(for: currentStyle)
        return result
    }
}

extension HeaderCollectionViewFlowLayout {
    private var delegate: HeaderCollectionViewFlowLayoutDelegate? {
        return collectionView?.delegate as? HeaderCollectionViewFlowLayoutDelegate
    }
    
    private func headerHeight(for style: HeaderStyle) -> CGFloat {
        if let delegate = delegate {
            return delegate.headerCollectionViewFlowLayout(self, headerHeightForStyle: style)
        }
        return 0
    }
    
    private var headerDiffHeight: CGFloat {
        return headerHeight(for: .extend) - headerHeight(for: .fold)
    }
    
    private func registerExtendDecorationView(_ viewClass: AnyClass?) {
        register(viewClass, forDecorationViewOfKind: HeaderStyle.extend.elementKindString)
    }
    
    private func registerFoldDecorationView(_ viewClass: AnyClass?) {
        register(viewClass, forDecorationViewOfKind: HeaderStyle.fold.elementKindString)
    }
}

extension IndexPath {
    static let holder = IndexPath(row: 0, section: 0)
}

extension UICollectionViewLayoutAttributes {
    var copyAttributes: Self? {
        return copy() as? Self
    }
}
