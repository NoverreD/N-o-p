//
//  CollectionViewFlowLayout.swift
//  Nop
//
//  Created by dengzhihao on 2022/7/20.
//

import UIKit

protocol CollectionViewFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionViewFlowLayout(_ layout: CollectionViewFlowLayout,
                                  headerHeightForStyle style: CollectionViewFlowLayout.HeaderStyle) -> CGFloat
}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    static let foldIdentifier = "fold.CollectionViewFlowLayout"
    static let extendIdentifier = "extend.CollectionViewFlowLayout"
    
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
    
    func registerExtendDecorationView(_ viewClass: AnyClass?) {
        register(viewClass, forDecorationViewOfKind: Self.extendIdentifier)
    }
    
    func registerFoldDecorationView(_ viewClass: AnyClass?) {
        register(viewClass, forDecorationViewOfKind: Self.foldIdentifier)
    }
    
    private var hasRegistedFlag: [HeaderStyle: Bool] = [:]
    private func hasRegisted(for style: HeaderStyle) -> Bool {
        return hasRegistedFlag[style] == true
    }
    private func updateHasRegistedFlag(_ obj: Any?, forDecorationViewOfKind elementKind: String) {
        if elementKind == Self.extendIdentifier {
            hasRegistedFlag[.extend] = obj != nil
        }
        if elementKind == Self.foldIdentifier {
            hasRegistedFlag[.fold] = obj != nil
        }
    }
    
    override func register(_ viewClass: AnyClass?, forDecorationViewOfKind elementKind: String) {
        updateHasRegistedFlag(viewClass, forDecorationViewOfKind: elementKind)
        super.register(viewClass, forDecorationViewOfKind: elementKind)
    }
    
    override func register(_ nib: UINib?, forDecorationViewOfKind elementKind: String) {
        updateHasRegistedFlag(nib, forDecorationViewOfKind: elementKind)
        super.register(nib, forDecorationViewOfKind: elementKind)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var todoRect = rect
        if hasRegisted(for: currentStyle) {
            todoRect = rect.insetBy(dx: 0, dy: -headerHeight(for: currentStyle))
        }
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
                    if [HeaderStyle.fold.kindString, HeaderStyle.extend.kindString].contains(representedElementKind) {
                        originLayoutArrtibutes.remove(at: index)
                    } else if let temp = layoutAttributesForDecorationView(ofKind: representedElementKind, at: attributes.indexPath) {
                        originLayoutArrtibutes[index] = temp
                    }
                }
            default:
                break
            }
        }
        if hasRegisted(for: currentStyle),
           let temp = layoutAttributesForDecorationView(ofKind: currentStyle.kindString, at: .holder) {
            originLayoutArrtibutes.append(temp)
        }
        return originLayoutArrtibutes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case HeaderStyle.extend.kindString:
            if !hasRegisted(for: .extend) {
                return nil
            }
            if currentStyle != .extend {
                return nil
            }
            let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
            attributes.frame = CGRect(x: 0, y: 0, width: collectionViewContentSize.width, height: headerHeight(for: .extend))
            attributes.zIndex = .max - 10
            attributes.alpha = currentStyle == .extend ? 1 : 0
            return attributes
        case HeaderStyle.fold.kindString:
            if currentStyle != .fold {
                return nil
            }
            if !hasRegisted(for: .fold) {
                return nil
            }
            let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
            attributes.frame = CGRect(x: 0, y: max(0, collectionView?.contentOffset.y ?? 0), width: collectionViewContentSize.width, height: headerHeight(for: .fold))
            attributes.zIndex = .max
            attributes.alpha = currentStyle == .fold ? 1 : 0
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
        result.invalidateDecorationElements(ofKind: HeaderStyle.fold.kindString, at: [.holder])
        result.invalidateDecorationElements(ofKind: HeaderStyle.extend.kindString, at: [.holder])
        if let temp = result as? UICollectionViewFlowLayoutInvalidationContext {
            temp.invalidateFlowLayoutAttributes = true
            temp.invalidateFlowLayoutDelegateMetrics = false
        }
        if currentStyle == .extend, newBounds.origin.y >= (headerHeight(for: .extend) - headerHeight(for: .fold)) {
            currentStyle = .fold
            invalidateLayout()
            result.contentOffsetAdjustment = CGPoint(x: 0, y: -newBounds.origin.y)
            result.contentSizeAdjustment = CGSize(width: 0, height: headerHeight(for: .extend) - headerHeight(for: .fold))
        }
        return result
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if !hasRegisted(for: currentStyle) {
            return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        }
        let originArrtibutes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)?.copyAttributes
        if currentStyle == .extend {
            originArrtibutes?.frame.origin.y += max(headerHeight(for: .fold), (headerHeight(for: .extend) - max(0, collectionView?.bounds.origin.y ?? 0)))
        } else {
            originArrtibutes?.frame.origin.y += headerHeight(for: currentStyle)
        }
        return originArrtibutes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if !hasRegisted(for: currentStyle) {
            return super.layoutAttributesForItem(at: indexPath)
        }
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
        if currentStyle == .extend, hasRegisted(for: .extend), result.y < headerHeight(for: .extend) {
            result.y = headerHeight(for: .extend) - headerHeight(for: .fold) + 0.1
        }
        return result
    }
    
    override var collectionViewContentSize: CGSize {
        var result = super.collectionViewContentSize
        if hasRegisted(for: currentStyle) {
            result.height += headerHeight(for: currentStyle)
        }
        return result
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
    }
}

extension CollectionViewFlowLayout {
    enum HeaderStyle {
        case extend
        case fold
        var kindString: String {
            switch self {
            case .extend:
                return CollectionViewFlowLayout.extendIdentifier
            case .fold:
                return CollectionViewFlowLayout.foldIdentifier
            }
        }
    }
    
    var delegate: CollectionViewFlowLayoutDelegate? {
        return collectionView?.delegate as? CollectionViewFlowLayoutDelegate
    }
    
    func headerHeight(for style: HeaderStyle) -> CGFloat {
        if let delegate = delegate {
            return delegate.collectionViewFlowLayout(self, headerHeightForStyle: style)
        }
        return 0
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
