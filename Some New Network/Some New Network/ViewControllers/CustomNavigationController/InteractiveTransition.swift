//
//  InteractiveTransition.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 15.02.2022.
//

import UIKit

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController? {
        didSet {
            let panGestureRecoghizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            viewController?.view.addGestureRecognizer(panGestureRecoghizer)
        }
    }
    
    var complete = false
    var isAnimationStarted = false
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
            
        case .began:
            isAnimationStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
            self.pause()
            
        case .changed:
            var translation = recognizer.translation(in: recognizer.view)
            if translation.x < 0 { translation.x = -translation.x }
            
            let percentComplete = translation.x / (recognizer.view?.frame.width ?? 1)
            let progress = max(0, min(1, percentComplete))
            if progress > 0.3 { complete = true}
            self.update(progress)
            
        case .ended:
            isAnimationStarted = false
            if complete {
                self.finish()
            }
            else {
                self.cancel()
            }
            
        default:
            isAnimationStarted = false
            return
        }
    }
    
    
    
}

