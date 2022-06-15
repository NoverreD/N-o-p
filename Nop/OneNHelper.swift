//
//  OneNHelper.swift
//  Nop
//
//  Created by dengzhihao on 2021/7/18.
//

import Foundation

struct OneNHelper {
    private var readerCount = 0
    private let semaphoreForRC = DispatchSemaphore(value: 1)
    private let semaphoreForAction = DispatchSemaphore(value: 1)
    
    func oneAction(action: ()->()) {
        semaphoreForAction.wait()
        
        action()
        
        semaphoreForAction.signal()
    }
    
    mutating func nAction<T>(action: ()->T) -> T {
        semaphoreForRC.wait()
        
        readerCount += 1
        
        if readerCount == 1{
            semaphoreForAction.wait()
        }
        
        semaphoreForRC.signal()
        
        let result = action()
        
        semaphoreForRC.wait()
        
        readerCount -= 1
        
        if readerCount == 0 {
            semaphoreForAction.signal()
        }
        
        semaphoreForRC.signal()
        return result
    }
    
}
