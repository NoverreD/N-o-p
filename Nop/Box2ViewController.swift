//
//  Box2ViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/12/23.
//

import UIKit

protocol Punchable {
    var weapon: String { get }
    func Punch(other: Self?)
}

protocol PunchableBox {
    func _Punch(other: PunchableBox?)
    
    var _weapon: String { get }
    
    var _canonicalBox: PunchableBox { get }

    func _unbox<T: Punchable>() -> T?
}

extension PunchableBox {
    var _canonicalBox: PunchableBox {
        return self
    }
}

class PunchableBoxParse<H: Punchable> : PunchableBox {
    func _unbox<T>() -> T? where T : Punchable {
        return h as? T
    }
    
    var _weapon: String {
        return h.weapon
    }

    var h: H

    init(h: H) {
        self.h = h
    }

    func _Punch(other: PunchableBox?) {
        if let other: H = other?._unbox() {
            h.Punch(other: other)
        }
    }
}


//class PunchableBox<T> {
//    func Punch(other: T?) {
//
//    }
//
//    var weapon: String {
//        return t.weapon
//    }
//}

//class PunchableBoxParse<H: Punchable> : PunchableBox {
//
//    override var weapon: String {
//        return h.weapon
//    }
//
//    var h: H
//
//    init(h: H) {
//        self.h = h
//    }
//
//    override func Punch(other: PunchableBox?) {
//        h.Punch(other: other)
//    }
//}
//
struct AnyPunchable: Punchable {
    var weapon: String {
        _box._weapon
    }

    var _box: PunchableBox

    func Punch(other: AnyPunchable?) {
        _box._Punch(other: other?._box)
    }

    public init<H>(_ base: H) where H : Punchable {
        _box = PunchableBoxParse(h: base)
    }
}

extension AnyPunchable {
    @_alwaysEmitIntoClient
      public __consuming func _toCustomAnyHashable() -> AnyPunchable? {
        return self
      }
}

struct APeople: Punchable {
    var weapon: String

    func Punch(other: APeople?) {
        print("\(weapon) -- \(other?.weapon ?? "")")
    }
}

struct BPeople: Punchable {
    var weapon: String

    func Punch(other: BPeople?) {
        print("\(weapon) ++ \(other?.weapon ?? "")")
    }
}

class Box2ViewController: UIViewController {

    var aPunchable: AnyPunchable? = AnyPunchable(APeople(weapon: "09"))
    var bPunchable: AnyPunchable? = AnyPunchable(BPeople(weapon: "87"))

    override func viewDidLoad() {
        super.viewDidLoad()
        aPunchable?.Punch(other: bPunchable)
        bPunchable?.Punch(other: aPunchable)
        // Do any additional setup after loading the view.
    }

}
