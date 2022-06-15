//
//  TableViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/11/18.
//

import UIKit

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 500)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableView.scrollToRow(at: IndexPath(row: 10, section: 0), at: .bottom, animated: false)
    }

    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableView")
        temp.dataSource = self
        return temp
    }()

}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableView", for: indexPath)
//        cell.contentView.backgroundColor = UIColor.randomColor
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
}
