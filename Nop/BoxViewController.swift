//
//  BoxViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/12/23.
//

import UIKit

protocol Printer {
    associatedtype T
    func print(val: T)
}

class _AnyPrinterBoxBase<E>: Printer {
    typealias T = E

    func print(val: E) {
        fatalError()
    }
}

class _PrinterBox<Base: Printer>: _AnyPrinterBoxBase<Base.T> {
    var base: Base
    
    init(_ base: Base) {
        self.base = base
    }

    override func print(val: Base.T) {
        base.print(val: val)
    }
}

struct AnyPrinter<T>: Printer {
    var _box: _AnyPrinterBoxBase<T>
        
    init<Base: Printer>(_ base: Base) where Base.T == T {
        _box = _PrinterBox(base)
    }

    func print(val: T) {
        _box.print(val: val)
    }
}

class BoxViewController: UIViewController {
    
    var a: AnyPrinter<Int>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
