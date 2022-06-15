//
//  ObserverHelper.swift
//  Nop
//
//  Created by dengzhihao on 2021/7/16.
//

import Foundation

public class ObserverHelper<T>{
    
    private var container: [(key: ObserverHandle, observer: Any)] = []
        
    private var oneNHelper = OneNHelper()
        
    @discardableResult public func register(_ obj: T) -> NSObjectProtocol {
        var result = ObserverHandle(key: UUID().uuidString)
        oneNHelper.oneAction {
            if let obj = obj as? NSObjectProtocol {
                for (key, observer) in container {
                    if let weakRef = observer as? SMJWeakObject<AnyObject>, weakRef.value === obj {
                        result = key
                        return
                    }
                }
                container.append((result, SMJWeakObject<AnyObject>(value: obj)))
                removeReleasedObj()
            } else {
                container.append((result, obj))
            }
        }
        return result
    }
    
    public func unregister(_ obj: T) where T: AnyObject {
        oneNHelper.oneAction {
            for (index, (_, observer)) in container.reversed().enumerated() {
                if let weakRef = observer as? SMJWeakObject<AnyObject>, weakRef.value === obj {
                    container.remove(at: container.count - 1 - index)
                    break
                }
            }
            removeReleasedObj()
        }
    }
    
    public func unregister(_ key: NSObjectProtocol) {
        guard let handle = key as? ObserverHandle else {
            return
        }
        oneNHelper.oneAction {
            for (index, (thisHandle, _)) in container.reversed().enumerated() {
                if thisHandle.key == handle.key {
                    container.remove(at: container.count - 1 - index)
                    break
                }
            }
            removeReleasedObj()
        }
    }

    public func unregisterAll() {
        oneNHelper.oneAction {
            container.removeAll()
        }
    }
    
    public func walk(action: (T) -> Void) {
        oneNHelper.nAction {
            for (_, observer) in container {
                if let weakRef = observer as? SMJWeakObject<AnyObject>, let value = weakRef.value as? T {
                    action(value)
                } else if let value = observer as? T {
                    action(value)
                }
            }
        }
    }
  
    private func removeReleasedObj() {
        let count = container.count
        for (index, (_, observer)) in container.reversed().enumerated() {
            if let weakRef = observer as? SMJWeakObject<AnyObject>, weakRef.value == nil {
                container.remove(at: count - 1 - index)
            }
        }
    }
}

extension ObserverHelper {
    private class ObserverHandle: NSObject {
        let key: String
        init(key: String) {
            self.key = key
        }
    }
}

