//
//  FontViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/21.
//

import UIKit

protocol FontViewControllerDelegate: AnyObject {
    func fontViewController(_ viewController: FontViewController, didSelect font: UIFont?)
}

class FontViewController: UIViewController {

    var dataSource: [UIFont] = []
    
    weak var delegate: FontViewControllerDelegate?
    
    var fontSize: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        dataSource.removeAll()
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                if let font = UIFont(name: fontName, size: fontSize) {
                    dataSource.append(font)
                }
            }
        }
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "size", style: .plain, target: self, action: #selector(onRightBarButtonItem))
    }
    
    @objc func onRightBarButtonItem() {
        let vc = UIAlertController(title: "font size", message: nil, preferredStyle: .alert)
        vc.addTextField { textField in
            if let text = textField.text, let size = Int(text) {
                self.fontSize = CGFloat(size)
            }
        }
        vc.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.dataSource = self
        temp.delegate = self
        return temp
    }()
    
    static let cellReuseIdentifier = "FontViewController.UITableViewCell.ReuseIdentifier"
}

extension FontViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let temp = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseIdentifier) {
            cell = temp
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Self.cellReuseIdentifier)
        }
        let font = dataSource[indexPath.row]
        cell.detailTextLabel?.text = font.fontName
//        cell.textLabel?.attributedText = NSAttributedString(string: "あA", attributes: [
//            .font: font
//        ])
        cell.textLabel?.text = "\(font.leading)"
        return cell
    }
}

extension FontViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let font = dataSource[indexPath.row].withSize(fontSize)
        delegate?.fontViewController(self, didSelect: font)
    }
}
