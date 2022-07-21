//
//  BaseCellProtocols.swift
//  Nop
//
//  Created by dengzhihao on 2022/7/21.
//

import UIKit

public struct CellHelper {
    ///TableView
    public struct TB {
        public typealias Cell = BaseTableViewCell
        public typealias Data = BaseTableViewCellDataProtocol
        public typealias Handler = TableViewCellActionProcessable
    }
    ///CollectionView
    public struct CV {
        public typealias Cell = BaseCollectionViewCell
        public typealias Data = BaseCollectionViewCellDataProtocol
        public typealias Handler = CollectionViewCellActionProcessable
    }
}

public protocol BaseCellDataProtocol {
    var reuseIdentifier: String { get }
}

public protocol BaseCellProtocol {
    static var reuseIdentifier: String { get }
}

extension BaseCellProtocol {
    public static var reuseIdentifier: String {
        return "\(Self.self)"
    }
}

public typealias CellActionHandler<CellProtocol> = (_ thisCell: CellProtocol
                                                    ,_ sender: Any?
                                                    ,_ context: [String: Any]?) -> Void

