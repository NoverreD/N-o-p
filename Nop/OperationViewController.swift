//
//  OperationViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/9/2.
//

import UIKit

class OperationViewController: UIViewController {

    let queue = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let a1 = MyOperation { thisOp in
            print("1111")
            thisOp.finish()
            OperationQueue.main.addOperation {
                print("main-1111")
            }
        }
        let a2 = MyOperation { thisOp in
            print("2222 - 0")
            thisOp.cancel()
        }
        a2.completionBlock = {
            print("a2 - completionBlock")
        }
        let a4 = MyOperation { thisOp in
            if a2.isCancelled {
                print("4444 - 1")
            } else {
                print("4444 - 2")
            }
            thisOp.finish()
        }
        let a3 = MyOperation {[weak a4] thisOp in
            if a1.isCancelled {
                print("3333 - 1")
            } else {
                print("3333 - 2")
            }
            sleep(2)
            a4?.cancel()
            thisOp.finish()
        }

        let a5 = SDAsyncBlockOperation { thisOp in
            print("555 - 1")
            thisOp.complete()
        }
        
        a2.addDependency(a1)
        a3.addDependency(a1)
        a4.addDependency(a3)
        a5.addDependency(a4)
        queue.addOperation(a1)
        queue.addOperation(a3)
        queue.addOperation(a2)
        queue.addOperation(a4)
        queue.addOperation(a5)
        a1.cancel()
        
        print("????")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function)")
    }
}

class MyOperation: Operation {
    enum State: Equatable {
        case executing
        case finished
        case cancel
        var isEnd: Bool {
            switch self {
            case .executing:
                return false
            case .cancel, .finished:
                return true
            }
        }
    }

    private let operationBlock: OperationBlock
    
    private var state: State?
    
    private let recursiveLock = NSRecursiveLock()
    
    typealias OperationBlock = (_ thisOp: MyOperation) -> Void
    
    init(_ operationBlock: @escaping OperationBlock) {
        self.operationBlock = operationBlock
    }
    
    func finish() {
        if !isExecuting {
            makeCancelled()
            return
        }
        makeFinished()
    }

    private func makeFinished() {
        recursiveLock.lock()
        willChangeValue(for: \.isFinished)
        willChangeValue(for: \.isExecuting)
        state = .finished
        didChangeValue(for: \.isExecuting)
        didChangeValue(for: \.isFinished)
        recursiveLock.unlock()
    }
    
    private func makeCancelled() {
        recursiveLock.lock()
        willChangeValue(for: \.isFinished)
        willChangeValue(for: \.isExecuting)
        state = .cancel
        didChangeValue(for: \.isExecuting)
        didChangeValue(for: \.isFinished)
        recursiveLock.unlock()
    }
    
    // MARK: - override
    override var isExecuting: Bool {
        recursiveLock.lock()
        let result = state == .executing
        recursiveLock.unlock()
        return result
    }
    
    override var isFinished: Bool {
        recursiveLock.lock()
        let result = state?.isEnd == true
        recursiveLock.unlock()
        return result
    }
    
    override var isConcurrent: Bool {
        return true
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        recursiveLock.lock()
        if isCancelled {
            willChangeValue(for: \.isFinished)
            state = .cancel
            didChangeValue(for: \.isFinished)
            recursiveLock.unlock()
            return
        }
        willChangeValue(for: \.isExecuting)
        state = .executing
        didChangeValue(for: \.isExecuting)
        recursiveLock.unlock()
        main()
    }
    
    override func main() {
        if isCancelled {
            makeCancelled()
            return
        }
        operationBlock(self)
    }
    
    override func cancel() {
        super.cancel()
        if isExecuting {
            makeCancelled()
        }
    }
    
    deinit {
        print("MyOperation deinit")
    }
}
