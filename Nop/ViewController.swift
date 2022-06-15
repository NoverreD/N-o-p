//
//  ViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/6/3.
//

import UIKit

//MARK: - HasKey && HasDefault && Nextable

public protocol HasKey {
    var key: String { get }
}

public extension HasKey where Self: RawRepresentable, Self.RawValue == String {
    var key: String {
        return self.rawValue
    }
}

public protocol HasDefault {
    associatedtype ValueType
    var defaultValue: ValueType { get }
}

public protocol Nextable {
    var next: Self? {get}
}

extension Nextable{
    var next: Self? {
        return nil
    }
}

/*
typealias IMEThemeValueKey = HasKey & HasDefault
*/
public protocol IMEThemeValueKey: HasKey, HasDefault {
    
}

//MARK: IMEThemeColorKey

public protocol IMEThemeColorNameKey:Nextable, IMEThemeValueKey where ValueType == String {
}

enum MyColorKey:String, IMEThemeColorNameKey {
    var defaultValue: String {
        return ""
    }
    case aColor
}

protocol IMEThemeImageKey:Nextable, HasKey {
    var baseFolder: String? { get }
    var adaptingRule: Int { get }
}

extension IMEThemeImageKey {
    var baseFolder: String? {
        return nil
    }
    
    var adaptingRule: Int {
        return 0
    }
}

enum MyImageKey:String, IMEThemeImageKey {
    case aImage
}

struct CellDataUnit {
    var isSelected = false
}

class ViewController: UIViewController {

    static let forCellWithReuseIdentifier = "forCellWithReuseIdentifier.ViewController"
        
    
    var dataSource: [CellDataUnit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        for _ in 0...10 {
            dataSource.append(CellDataUnit())
        }
        dataSource[3].isSelected = true
        collectionView.selectItem(at: IndexPath(row: 3, section: 0), animated: true, scrollPosition: .bottom)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 400)
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        temp.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: ViewController.forCellWithReuseIdentifier)
        temp.dataSource = self
        temp.delegate = self
        return temp
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dataSource[2].isSelected = true
        for indexPath in collectionView.indexPathsForSelectedItems ?? [] {
            dataSource[indexPath.row].isSelected = indexPath.row == 2
        }
        collectionView.selectItem(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .top)
        print(dataSource)
        print(collectionView.indexPathsForSelectedItems ?? [])
    }
}

extension ViewController {
    func addSubviews() {
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.forCellWithReuseIdentifier, for: indexPath)
        cell.isSelected = dataSource[indexPath.row].isSelected
        return cell
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        
        set {
            super.isSelected = newValue
            if newValue {
                contentView.backgroundColor = UIColor.yellow
            } else {
                contentView.backgroundColor = UIColor.red
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource[indexPath.row].isSelected = true
        print("\(#function) \(indexPath)")
        print(dataSource)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("\(#function) \(indexPath)")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        print("\(#function) \(indexPath)")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
        dataSource[indexPath.row].isSelected = false
        print(dataSource)
    }
}


fileprivate extension UserDefaults {
    func value<T>(for key: String, defaultValue: T) -> T {
        return (value(forKey:key) as? T) ?? defaultValue
    }
    
    func value<T>(for key: String) -> T? {
        return value(forKey:key) as? T
    }
}
