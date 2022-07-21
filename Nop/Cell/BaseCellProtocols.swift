//
//  BaseCellProtocols.swift
//  Nop
//
//  Created by dengzhihao on 2022/7/21.
//

import UIKit

struct CellHelper {
    ///TableView
    struct TB {
        typealias Cell = BaseTableViewCell
        typealias Data = BaseTableViewCellDataProtocol
    }
    ///CollectionView
    struct CV {
        typealias Cell = BaseCollectionViewCell
        typealias Data = BaseCollectionViewCellDataProtocol
    }
}

public protocol BaseCellDataProtocol {
    var reuseIdentifier: String { get }
}

public typealias CellActionHandler<CellProtocol> = (_ thisCell: CellProtocol
                                                    ,_ sender: Any?
                                                    ,_ context: [String: Any]?) -> Void

