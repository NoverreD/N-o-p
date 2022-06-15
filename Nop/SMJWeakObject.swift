//
//  SMJWeakObject.swift
//  Nop
//
//  Created by dengzhihao on 2021/7/16.
//

import Foundation

public class SMJWeakObject<T: AnyObject>: Equatable, Hashable {
    public weak var value: T?
    public init(value: T) {
        self.value = value
    }
    
    public func hash(into hasher: inout Hasher) {
        if let value = self.value {
            hasher.combine(Unmanaged.passUnretained(value).toOpaque())
        } else {
            hasher.combine(0)
        }
    }

    public static func == <T> (lhs: SMJWeakObject<T>, rhs: SMJWeakObject<T>) -> Bool {
        return lhs.value === rhs.value
    }
}
