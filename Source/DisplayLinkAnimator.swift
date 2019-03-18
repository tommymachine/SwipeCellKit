//
//  DisplayLinkAnimator.swift
//  Do
//
//  Created by Thompson Fletcher on 3/17/19.
//  Copyright © 2019 Thompson Fletcher. All rights reserved.
//

import Foundation

class DisplayLinkAnimator {
    
    var duration: Double = 0
    
    var progress: Double {
        return (link.timestamp - startTimeStamp)/duration
    }
    
    var startTimeStamp: CFTimeInterval!
    
    var animations: (Double) -> Void = {_ in}
    
    var link: CADisplayLink!
    
    @objc func linkFired() {
        if startTimeStamp == nil {
            startTimeStamp = link.timestamp
        }
        
        animations(timingFunction.solve(progress))
        
        if progress >= 1 {
            stopLink()
        }
    }
    
    func startLink() {
        link = CADisplayLink(target: self, selector: #selector(linkFired))
        link.add(to: .main, forMode: .common)
    }
    
    func stopLink() {
        link.invalidate()
        link.remove(from: .main, forMode: .common)
    }
    
    init(with duration: Double, animations: @escaping (Double) -> Void) {
        self.duration = duration
        self.animations = animations
        startLink()
    }
    
    var timingFunction = Cubic.easeInOut.timingFunction
    
}
