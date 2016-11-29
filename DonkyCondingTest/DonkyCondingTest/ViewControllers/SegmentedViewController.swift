//
//  SegmentedViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

    let viewControllers: Array<UIViewController>
    var currentViewController: UIViewController
    
    init(viewControllers: Array<UIViewController>) {
        self.viewControllers = viewControllers
        currentViewController = viewControllers.first!
        super.init(nibName: "SegmentedViewController", bundle: Bundle(for: SegmentedViewController.self))
        
        for vc in viewControllers {
            addChildViewController(vc)
            vc.willMove(toParentViewController: self)
        }
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentViewController.beginAppearanceTransition(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentViewController.endAppearanceTransition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentViewController.beginAppearanceTransition(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentViewController.endAppearanceTransition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        segmentedControl.removeAllSegments()
        for (idx, vc) in viewControllers.enumerated() {
            segmentedControl.insertSegment(withTitle: vc.title, at: idx, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        setupFirstViewController()
    }
    
    private func setupFirstViewController() {
        let vc = currentViewController
        vc.view.frame = containerView.bounds
        if isVisible {
            vc.beginAppearanceTransition(true, animated: false)
        }
        containerView.addSubview(vc.view)
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if isVisible {
            vc.endAppearanceTransition()
        }
    }
    
    @IBAction func onTabChange(_ sender: UISegmentedControl) {
        let fromVC = currentViewController
        let idx = sender.selectedSegmentIndex
        let toVC = viewControllers[idx]
        transition(from: fromVC, to: toVC)
        currentViewController = toVC
    }
    
    private func transition(from: UIViewController, to: UIViewController) {
        from.beginAppearanceTransition(false, animated: true)
        to.beginAppearanceTransition(true, animated: true)
        
        let container = self.containerView!
        UIView.transition(
            with: container,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: {
                
                from.view.removeFromSuperview()
                to.view.frame = container.bounds
                container.addSubview(to.view)
                to.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
        }, completion: {
            (_) in
            to.endAppearanceTransition()
            from.endAppearanceTransition()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
