//
//  WQLayer+BasicAnimation.swift
//  Pods-WQBasicModules_Example
//
//  Created by WangQiang on 2018/11/4.
//

import UIKit
public extension CALayer {
    struct AnimationKeys {
        static let rotation = "wq.layer.anmations.rotation"
        static let transition = "wq.layer.anmations.transition"
        static let isAnimating = UnsafeRawPointer(bitPattern: "wq.layer.anmations.isAnimating".hashValue)!
    }
    
    public private(set) var isAnimating: Bool {
        set {
            objc_setAssociatedObject(self, AnimationKeys.isAnimating, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return (objc_getAssociatedObject(self, AnimationKeys.isAnimating) as? Bool) ?? false
        }
    }
    
    @discardableResult
    public func rotation(_ from: Double = 0,
                  to angle: Double = Double.pi * 2,
                  duration: Double,
                  isRepeat: Bool) -> CABasicAnimation {
        let keyPath = "transform.rotation"
        let animate = CABasicAnimation(keyPath: keyPath)
        animate.fromValue = Double(0)
        animate.toValue = angle
        animate.repeatCount = isRepeat ? MAXFLOAT : 1
        animate.duration = duration
        animate.isRemovedOnCompletion = false
        self.interal_add(animate, forKey: AnimationKeys.rotation)
        return animate
    }
     
    public func stopRotation() {
        self.interal_remove(forKey: AnimationKeys.rotation)
    }
    
    @discardableResult
    public func transition(timing: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeInEaseOut),
                           type: CATransitionType = .fade,
                           duration: CFTimeInterval = 0.2) -> CATransition {
        let transtion = CATransition()
        transtion.duration = duration
        transtion.timingFunction = timing
        transtion.type = type
        self.interal_add(transtion, forKey: AnimationKeys.transition)
        return transtion
    }
    
    public func stopTransition() {
        self.interal_remove(forKey: AnimationKeys.transition)
    }
    
    private func interal_add(_ animate: CAAnimation, forKey key: String) {
        if self.animation(forKey: key) != nil {
           self.removeAnimation(forKey: key)
        }
        animate.delegate = self
        self.add(animate, forKey: key)
    }
    private func interal_remove(forKey key: String) {
        self.removeAnimation(forKey: key)
    }
}

extension CALayer: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        self.isAnimating = true
    }
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isAnimating = false
    }
}
