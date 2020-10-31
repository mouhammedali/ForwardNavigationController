//
//  TransitionAnimator.swift
//  ForwardNavigationController
//
//  Created by Mouhammed Ali on 10/31/20.
//

import UIKit

final class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let presenting: Bool
    
    private var isRTL: Bool
    
    init(presenting: Bool, isRTL: Bool) {
        self.presenting = presenting
        self.isRTL = isRTL
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            pushAnimation(transitionContext)
        } else {
            popAnimation(transitionContext)
        }
    }
    
    private func pushAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewController(forKey: .to),
           let fromViewController = transitionContext.viewController(forKey: .from) {
            
            let fromVCFrame = fromViewController.view.frame
            let time = transitionDuration(using: transitionContext)
            
            var startPosition = toViewController.view.frame.size.width
            if let view = toViewController.view {
                transitionContext.containerView.addSubview(view)
            }
            if isRTL {
                startPosition = -startPosition
            }
            
            toViewController.view.frame = fromVCFrame.offsetBy(dx: startPosition, dy: 0)
            fromViewController.view.alpha = 1.0
            CATransaction.begin()
            CATransaction.setAnimationDuration(time)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.23, 0.01, 0, 0.99))
            if transitionContext.isInteractive{
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0, 0.16, 1, 1))
            }
            UIView.animate(withDuration: time, delay: 0, options: [ .preferredFramesPerSecond60 ], animations: {
                fromViewController.view.frame = fromVCFrame.offsetBy(dx: -startPosition/5, dy: 0)
                fromViewController.view.alpha = 0.8
                toViewController.view.frame = fromVCFrame
            }) { finished in
                fromViewController.view.frame = fromVCFrame
                fromViewController.view.alpha = 1.0
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            CATransaction.commit()
        }
    }
    
    private func popAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewController(forKey: .to),
           let fromViewController = transitionContext.viewController(forKey: .from) {
            let time = transitionDuration(using: transitionContext)
            let fromVCFrame = fromViewController.view.frame
            
            let containerView = transitionContext.containerView
            var startPosition = toViewController.view.frame.size.width
            if isRTL {
                startPosition = -startPosition
            }
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            toViewController.view.alpha = 0.4
            
            toViewController.view.frame = fromVCFrame.offsetBy(dx: -startPosition/5, dy: 0)
            CATransaction.begin()
            CATransaction.setAnimationDuration(time)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.23, 0.01, 0, 0.99))
            if transitionContext.isInteractive{
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0, 0, 1, 0.94))
            }
            UIView.animate(
                withDuration:time , delay: 0, options: [.preferredFramesPerSecond60],
                animations: {
                    fromViewController.view.frame = fromVCFrame.offsetBy(dx: startPosition, dy: 0)
                    toViewController.view.frame = fromVCFrame
                    toViewController.view.alpha = 1.0
                }, completion: {
                    finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            
            CATransaction.commit()
        }
    }
    
}
