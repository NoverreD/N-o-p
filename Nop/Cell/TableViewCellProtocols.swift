//
//  TableViewCellProtocols.swift
//
//  Created by dengzhihao on 2022/7/21.
//

import UIKit

public typealias BaseTableViewCell = UITableViewCell & BaseTableViewCellProtocol
public protocol BaseTableViewCellDataProtocol: BaseCellDataProtocol {
    var cellType: BaseTableViewCell.Type { get }
}

extension BaseTableViewCellDataProtocol {
    public var reuseIdentifier: String {
        return cellType.reuseIdentifier
    }
}

public protocol BaseTableViewCellProtocol: BaseCellProtocol where Self: UITableViewCell {
    func reload(with data: BaseTableViewCellDataProtocol)
    var actionHandler: CellActionHandler<BaseTableViewCellProtocol>? { get set }
    static func cellHeight(in width: CGFloat, data: BaseTableViewCellDataProtocol?, context: [String: Any]?) -> CGFloat
}

extension BaseTableViewCellProtocol {
    public func callActionHandler(sender: Any? ,context: [String: Any]?) {
        actionHandler?(self, sender, context)
    }
    
    public static func cellHeight(in width: CGFloat, data: BaseTableViewCellDataProtocol?, context: [String: Any]?) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    var actionHandler: CellActionHandler<BaseTableViewCellProtocol>? {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKey.actionHandler) as? CellActionHandler<BaseTableViewCellProtocol>
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.actionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public protocol TableViewCellActionProcessable {
    func onCellActionHandler(_ thisCell: BaseTableViewCell
                             ,_ sender: Any?
                             ,_ context: [String: Any]?)
}

fileprivate struct AssociatedKey {
    static var actionHandler = "actionHandler"
}
