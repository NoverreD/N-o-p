//
//  CollectionViewCellProtocols.swift
//
//  Created by dengzhihao on 2022/7/21.
//

import UIKit

public typealias BaseCollectionViewCell = UICollectionViewCell & BaseCollectionViewCellProtocol
public protocol BaseCollectionViewCellDataProtocol: BaseCellDataProtocol {
    var cellType: BaseCollectionViewCell.Type { get }
}

extension BaseCollectionViewCellDataProtocol {
    public var reuseIdentifier: String {
        return cellType.reuseIdentifier
    }
}

public protocol BaseCollectionViewCellProtocol: BaseCellProtocol where Self: UICollectionViewCell {
    func reload(with data: BaseCollectionViewCellDataProtocol)
    var actionHandler: CellActionHandler<BaseCollectionViewCellProtocol>? { get set }
}

extension BaseCollectionViewCellProtocol {
    public func callActionHandler(sender: Any? ,context: [String: Any]?) {
        actionHandler?(self, sender, context)
    }
    
    var actionHandler: CellActionHandler<BaseCollectionViewCellProtocol>? {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKey.actionHandler) as? CellActionHandler<BaseCollectionViewCellProtocol>
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.actionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public protocol CollectionViewCellActionProcessable {
    func onCellActionHandler(_ thisCell: BaseCollectionViewCell
                             ,_ sender: Any?
                             ,_ context: [String: Any]?)
}

fileprivate struct AssociatedKey {
    static var actionHandler = "actionHandler"
}
