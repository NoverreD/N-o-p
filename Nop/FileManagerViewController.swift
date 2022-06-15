//
//  FileManagerViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/24.
//

import UIKit

class FileManagerViewController: UIViewController {

    var skipsSubdirectoryDescendants = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        updateDataSource()
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onRightBarButton(sender:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func onRightBarButton(sender: Any) {
        skipsSubdirectoryDescendants = !skipsSubdirectoryDescendants
        updateDataSource()
    }
    
    func updateDataSource() {
        var options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles]
        if skipsSubdirectoryDescendants {
            options.formUnion(.skipsSubdirectoryDescendants)
        }
        setupDataSource(url: urlForEnumerator, options: options)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupDataSource(url: URL?, options: FileManager.DirectoryEnumerationOptions) {
        let todoUrl = url ?? URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])
//        let todoUrl = URL(fileURLWithPath: NSTemporaryDirectory())
        guard let enumerator = FileManager.default.enumerator(at: todoUrl,
                                       includingPropertiesForKeys: [
                                        .fileSizeKey, .nameKey, .isDirectoryKey
                                       ],
                                       options: options,
                                       errorHandler: nil) else {
            return
        }
        dataSource.removeAll()
        for urlResource in enumerator {
            if let url = urlResource as? NSURL {
                dataSource.append(url)
            }
        }
    }
    
    var urlForEnumerator: URL?
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.dataSource = self
        temp.delegate = self
        return temp
    }()
        
    static let cellIdentifier = "\(UITableViewCell.self)"
    
    var dataSource: [NSURL] = []
}

extension FileManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let aCell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier) {
            cell = aCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Self.cellIdentifier)
        }
        let urlResource = dataSource[indexPath.row]
        
        var fileValue: AnyObject?
        try? urlResource.getResourceValue(&fileValue, forKey: .nameKey)
        cell.textLabel?.text = fileValue as? String
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        try? urlResource.getResourceValue(&fileValue, forKey: .fileSizeKey)
        if let size = fileValue as? NSNumber {
            cell.detailTextLabel?.text = "\(size.int64Value / 1024)"
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        } else {
            cell.detailTextLabel?.text = nil
        }
        try? urlResource.getResourceValue(&fileValue, forKey: .isDirectoryKey)
        if let isDir = fileValue as? NSNumber, isDir.boolValue {
            cell.contentView.backgroundColor = UIColor.green
        } else {
            cell.contentView.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension FileManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlResource = dataSource[indexPath.row]
        var fileValue: AnyObject?
        try? urlResource.getResourceValue(&fileValue, forKey: .isDirectoryKey)
        if let isDir = fileValue as? NSNumber, isDir.boolValue {
            let vc = FileManagerViewController()
            vc.urlForEnumerator = urlResource as URL
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
