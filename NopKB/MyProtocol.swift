//
//  MyProtocol.swift
//  NopKB
//
//  Created by dengzhihao on 2021/6/10.
//

import UIKit

protocol MyProtocol: NSObjectProtocol {
    func myName() -> String
}

protocol MyDadProtocol: MyProtocol{
    func myAge() -> Int
}

protocol MyMumProtocol: MyProtocol{
    func mySex() -> Int
}

extension NSObject: MyDadProtocol, MyMumProtocol {
    func mySex() -> Int {
        return 1
    }
    
    func myName() -> String {
        return ""
    }
    
    func myAge() -> Int {
        return 10
    }
    
    
}
