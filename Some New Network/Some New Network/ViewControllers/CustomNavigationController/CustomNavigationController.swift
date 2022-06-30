//
//  CustomNavigationController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 15.02.2022.
//

import UIKit

class CustomNavigationController: UINavigationController {

    let interactiveTransition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}


extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //return interactiveTransition
        return interactiveTransition.isAnimationStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var animator: UIViewControllerAnimatedTransitioning?
        
        if operation == .push {
            animator = AnimatorPush()
            //interactiveTransition.viewController = toVC
        }

        if operation == .pop {
            animator = AnimatorPop()
            //interactiveTransition.viewController = toVC
        }
        
        return animator
    }
}
