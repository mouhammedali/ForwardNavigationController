
//
//  ForwardNavigationController.swift
//  ForwardNavigationController
//
//  Created by Mouhammed Ali on 10/31/20.
//

import UIKit

public class ForwardNavigationController: UINavigationController {
    // MARK: - Properties
    private var interactionController: UIPercentDrivenInteractiveTransition?
    // MARK: - Public Properties
    var forwardVCs = [UIViewController]()
    @IBInspectable public var allowForward: Bool = true
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        setupGestures()
        delegate = self
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupGestures()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestures()
        delegate = self
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        if let popedVC = super.popViewController(animated: animated) {
            if !forwardVCs.contains(popedVC) {
                forwardVCs.append(popedVC)
            }
            return popedVC
        }
        return nil
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let vcs = super.popToViewController(viewController, animated: true) {
            forwardVCs.append(contentsOf: vcs.reversed())
            return vcs
        }
        return nil
    }
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if forwardVCs.last != viewController {
            forwardVCs.removeAll()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: Gesture Setup
    private func setupGestures() {
        let leftEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftSwipe(fromLeftEdge:)))
        leftEdge.edges = .left
        view.addGestureRecognizer(leftEdge)
        
        let rightEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleRightSwipe(fromRightEdge:)))
        rightEdge.edges = .right
        view.addGestureRecognizer(rightEdge)
    }
    
    // MARK: Gesture Handlers
    @objc func handleLeftSwipe(fromLeftEdge gesture: UIScreenEdgePanGestureRecognizer?) {
        if isRTL() {
            handleRTLPushSwipe(gesture)
        } else {
            handlePopSwipe(gesture)
        }
    }
    
    @objc func handleRightSwipe(fromRightEdge gesture: UIScreenEdgePanGestureRecognizer?) {
        if isRTL() {
            handleRTLPopSwipe(gesture)
        } else {
            handlePushSwipe(gesture)
        }
    }
    
    private func handlePopSwipe(_ gesture: UIScreenEdgePanGestureRecognizer?) {
        let translate = gesture?.translation(in: gesture?.view)
        let percent = (translate?.x ?? 0.0) / (gesture?.view?.bounds.size.width ?? 0.0)

        if gesture?.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            _ = popViewController(animated: true)
        } else if gesture?.state == .changed {
            interactionController?.update(percent)
        } else if gesture?.state == .ended {
            if percent > 0.5 {
                interactionController?.finish()
            } else {
                forwardVCs.removeLast()
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }
    
    private func handlePushSwipe(_ gesture: UIScreenEdgePanGestureRecognizer?) {
        if forwardVCs.count == 0 || !allowForward {
            return
        }
        let translate = gesture?.translation(in: gesture?.view)
        let percent = -(translate?.x ?? 0.0) / (gesture?.view?.bounds.size.width ?? 0.0)

        if gesture?.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            
            if let vc = forwardVCs.last {
                pushViewController(vc, animated: true)
            }
        } else if gesture?.state == .changed {
            interactionController?.update(percent)
        } else if gesture?.state == .ended {
            if percent > 0.5 {
                interactionController?.finish()
                forwardVCs.removeLast()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
        print(forwardVCs.count)
    }
    
    
    func handleRTLPushSwipe(_ gesture: UIScreenEdgePanGestureRecognizer?) {
        if forwardVCs.count == 0 || !allowForward {
            return
        }
        let translate = gesture?.translation(in: gesture?.view)
        let percent = (translate?.x ?? 0.0) / (gesture?.view?.bounds.size.width ?? 0.0)

        if gesture?.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            if let vc = forwardVCs.last {
                pushViewController(vc, animated: true)
            }
            
        } else if gesture?.state == .changed {
            interactionController?.update(percent)
            
        } else if gesture?.state == .ended {
            if percent > 0.5 {
                interactionController?.finish()
                forwardVCs.removeLast()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }
    
    func handleRTLPopSwipe(_ gesture: UIScreenEdgePanGestureRecognizer?) {
        let translate = gesture?.translation(in: gesture?.view)
        let percent = -(translate?.x ?? 0.0) / (gesture?.view?.bounds.size.width ?? 0.0)

        if gesture?.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            _ = popViewController(animated: true)
        } else if gesture?.state == .changed {
            interactionController?.update(percent)
        } else if gesture?.state == .ended {
            if percent > 0.5 {
                interactionController?.finish()
            } else {
                forwardVCs.removeLast()
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }

    private func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        
    }
}

// MARK: UINavigationController Delegate
extension ForwardNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(presenting: operation == .push, isRTL: isRTL())
    }
    
    public func navigationController(
        _ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
}
