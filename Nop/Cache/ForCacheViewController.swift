//
//  ForCacheViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/27.
//

import UIKit

class DownloadManager {
    
}

class ForCacheViewController: UIViewController {

    let downloadManager = DownloadManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let precondition = SMJSinceLastPrecondition.useDefaults(timeInterval: 100, key: "sdf")
        action(withPrecondition: precondition)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func action(withPrecondition precondition: SMJPrecondition) {
        guard precondition.canPerform() else {
            return
        }
        precondition.update()
    }
}

class SMJPrecondition {
    func canPerform(withcontext context: [String: Any]? = nil) -> Bool {
        return true
    }
    
    func update() {
        // do nothing
    }
}

class SMJSinceLastPrecondition: SMJPrecondition {
    var timeInterval: TimeInterval
    var markLast: (TimeInterval) -> Void
    var getLast: () -> TimeInterval
    var now: () -> TimeInterval

    required init(timeInterval: TimeInterval,
         markLast: @escaping (TimeInterval) -> Void,
         getLast: @escaping () -> TimeInterval,
         now: @escaping () -> TimeInterval = {
            return Date().timeIntervalSince1970
         }) {
        self.timeInterval = timeInterval
        self.markLast = markLast
        self.getLast = getLast
        self.now = now
    }
    
    override func canPerform(withcontext context: [String : Any]? = nil) -> Bool {
        let last = getLast()
        return now() - last >= timeInterval
    }
    
    override func update() {
        markLast(now())
    }
}

extension SMJSinceLastPrecondition {
    static func useDefaults(timeInterval: TimeInterval, key: String) -> Self {
        return Self.init(timeInterval: timeInterval) { timeInterval in
            UserDefaults.standard.setValue(timeInterval, forKey: key)
        } getLast: {
            return UserDefaults.standard.double(forKey: key)
        }
    }
}



