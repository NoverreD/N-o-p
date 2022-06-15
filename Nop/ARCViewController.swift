//
//  ARCViewController.swift
//  Nop
//
//  Created by dengzhihao on 2022/3/7.
//

import UIKit

let ii: OperationQueue = {
    let temp = OperationQueue()
    temp.maxConcurrentOperationCount = 1
    return temp
}()

class ARCViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        test4()
        printWhenDeinit(message: "--viewDidLoad-end--")
    }
    
    func test4() {
        autoreleasepool {
            let traveler = Traveler(name: "test4")
            printWhenDeinit(message: "--@autorelease-end--")
        }
        printWhenDeinit(message: "--test4-end--")
    }
    
    func test3() {
        let traveler = Traveler(name: "Lily")
        let traveler2 = Traveler(name: "Lily2")
        let traveler3 = Traveler(name: "Lily3")
        traveler2.name = "ABC"
        printWhenDeinit(message: "---==-----")
    }
    
    func test2 () {
        let traveler = Traveler(name: "Lily")
        let account = Account(traveler: traveler)
        traveler.account = account
        account.printSummary()
        print("test2 -- end")
    }
    
    
    func test() {
        let traveler1 = Traveler(name: "LiLy") // -- 引用计数为1
        // retain -- 引用计数为2
        let traveler2 = traveler1
        // release -- 引用计数为1
        traveler2.destination = "Big Sur"
        
        printWhenDeinit(message: "code - end")
        
        let traveler3 = Traveler(name: "L22iLy") // -- 引用计数为1
        // retain -- 引用计数为2
        let traveler4 = traveler3
        // release -- 引用计数为1
        traveler4.destination = "Big Sur"
        traveler2.destination = "Big Sur"

        printWhenDeinit(message: "code - end - 2")

        let traveler5 = Traveler(name: "L24442iLy") // -- 引用计数为1
        // retain -- 引用计数为2
        let traveler6 = traveler5
        // release -- 引用计数为1
        traveler6.destination = "Big Sur"
        
        printWhenDeinit(message: "code - end - 3")
    }
    
    private func printWhenDeinit(message: String) {
        ii.addOperation {
            print(message)
        }
    }
}

class Traveler {
    var name: String
    var destination: String?
    var account: Account?
    init(name: String, destination: String? = nil) {
        self.name = name
        self.destination = destination
    }
    
    deinit {
        let name = self.name
        ii.addOperation {
            print("\(name)")
        }
    }
}

class Account {
    weak var traveler: Traveler?
    var role: String = "snb"
    func printSummary() {
        print("\(traveler!.name) has xx \(self.role)")
    }
    
    init(traveler: Traveler) {
        self.traveler = traveler
    }
    
    deinit {
        ii.addOperation {
            print("ACCOUNT")
        }
    }
}
