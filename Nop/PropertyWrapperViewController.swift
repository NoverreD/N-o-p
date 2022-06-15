//
//  PropertyWrapperViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/12/22.
//

import UIKit

@propertyWrapper
struct PPPter<T: CustomStringConvertible> {
    
    let logName: String
    
    var projectedValue: Bool
    
    var wrappedValue: T {
        didSet {
            print("--- \(wrappedValue) | \(logName)")
        }
    }
    
    init(wrappedValue: T, logName: String) {
        self.wrappedValue = wrappedValue
        self.logName = logName
        self.projectedValue = true
        print("\(Data([1,1,1]))")
    }
}

class PropertyWrapperViewController: UIViewController {
    @PPPter<Int>(wrappedValue: 10, logName: "ageg - ge")
    var age: Int {
        didSet {
         print("didSet.age = \(age)")
        }
    }
        
    @PPPter<Int>(wrappedValue: 1, logName: "sadgg")
    var age2: Int
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hao : \(age)")
        add(value: &age)
        print("hao : \(age)")
        $age = false
    }
    
    func add( value: inout Int) {
        value+=1
    }
}
