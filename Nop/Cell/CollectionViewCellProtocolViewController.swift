//
//  CollectionViewCellProtocolViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/7/21.
//

import Foundation
import UIKit

class CollectionViewCellProtocolViewController: UICollectionViewController {
    
    lazy var dataSource: [CellHelper.CV.Data] = {
        var result: [CellHelper.CV.Data] = [
            CellA.CellData(aText: "ss"),
            CellB.CellData(aText: "sss")
        ]
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CellA.self, forCellWithReuseIdentifier: CellA.reuseIdentifier)
        collectionView.register(CellB.self, forCellWithReuseIdentifier: CellB.reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: data.reuseIdentifier, for: indexPath) as! CellHelper.CV.Cell
        cell.reload(with: data)
        return cell
    }
}

extension CollectionViewCellProtocolViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension CollectionViewCellProtocolViewController {

    
    class CellA: CellHelper.CV.Cell {
        var label: UILabel?
        
        func onLabelTap(sender: UITapGestureRecognizer) {
            callActionHandler(sender: sender, context: nil)
        }
        
        func reload(with data: BaseCollectionViewCellDataProtocol) {
            
        }
                
        struct CellData: CellHelper.CV.Data {
            var aText: String?
            var cellType: BaseCollectionViewCell.Type {
                return CellA.self
            }
        }
        
        static func cellHeight(in width: CGFloat, context: [String : Any]?) -> CGFloat {
            return 100
        }
    }

    class CellB: CellHelper.CV.Cell {
        func reload(with data: BaseCollectionViewCellDataProtocol) {
            
        }
        struct CellData: CellHelper.CV.Data {
            var aText: String?
            var cellType: BaseCollectionViewCell.Type {
                return CellB.self
            }
        }
    }
}
