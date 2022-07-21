//
//  TableViewCellProtocolViewController.swift
//
//  Created by dengzhihao on 2022/7/21.
//

import UIKit

class TableViewCellProtocolViewController: UITableViewController {

    lazy var dataSource: [BaseTableViewCellDataProtocol] = {
        var result: [BaseTableViewCellDataProtocol] = [
            CellA.CellData(aText: "ss"),
            CellB.CellData(bText: "sss"),
            CellC.CellData(cImage: nil)
        ]
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for aa in dataSource {
            print(aa.reuseIdentifier)
        }
        tableView.register(CellA.self, forCellReuseIdentifier: CellA.reuseIdentifier)
        tableView.register(CellB.self, forCellReuseIdentifier: CellB.reuseIdentifier)
        tableView.register(CellC.self, forCellReuseIdentifier: CellC.reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.reuseIdentifier, for: indexPath) as! BaseTableViewCell
        cell.reload(with: data)
        cell.actionHandler = onCellActionHandler
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = dataSource[indexPath.row]
        let cellType = data.cellType
        return cellType.cellHeight(in: tableView.bounds.width, data: data, context: nil)
    }

}

extension TableViewCellProtocolViewController: TableViewCellActionProcessable {
    func onCellActionHandler(_ thisCell: BaseTableViewCell, _ sender: Any?, _ context: [String : Any]?) {
        print("sender \(thisCell)")
    }
}

extension TableViewCellProtocolViewController {

    
    class CellA: BaseTableViewCell {
        var label: UILabel?
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLabelTap(sender:))))
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func reload(with data: BaseTableViewCellDataProtocol) {
            if let temp = data as? CellData {
                label?.text = temp.aText
            }
        }
        
        @objc func onLabelTap(sender: UITapGestureRecognizer) {
            callActionHandler(sender: sender, context: nil)
        }
                
        struct CellData: BaseTableViewCellDataProtocol {
            var aText: String?
            var cellType: BaseTableViewCell.Type {
                return CellA.self
            }
        }
        
        static func cellHeight(in width: CGFloat, data: BaseTableViewCellDataProtocol?, context: [String : Any]?) -> CGFloat {
            return 100
        }
    }

    class CellB: BaseTableViewCell {
        var label: UILabel?
        
        func reload(with data: BaseTableViewCellDataProtocol) {
            
        }
                
        struct CellData: BaseTableViewCellDataProtocol {
            var bText: String?
            var cellType: BaseTableViewCell.Type {
                return CellB.self
            }
        }
        
        static func cellHeight(in width: CGFloat, data: BaseTableViewCellDataProtocol?, context: [String : Any]?) -> CGFloat {
            return 30
        }
    }
    
    class CellC: BaseTableViewCell {
        var imageV: UIImageView?
        
        func reload(with data: BaseTableViewCellDataProtocol) {
            
        }
                
        struct CellData: BaseTableViewCellDataProtocol {
            var cImage: UIImage?
            var cellType: BaseTableViewCell.Type {
                return CellC.self
            }
        }
        
        static func cellHeight(in width: CGFloat, data: BaseTableViewCellDataProtocol?, context: [String : Any]?) -> CGFloat {
            return 40
        }
    }
}
