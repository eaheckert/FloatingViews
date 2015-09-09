//
//  FloatView.swift
//  FloatingView
//
//  Created by Eugene Heckert on 8/17/15.
//  Copyright (c) 2015 Eugene Heckert. All rights reserved.
//

import Foundation
import UIKit

class FloatingViewController: UIViewController
{
    private var floatingAnimator: UIDynamicAnimator!
    private var gravity: UIGravityBehavior!
    private var viewCollision: UICollisionBehavior!
    private var floatingViews = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        floatingAnimator = UIDynamicAnimator(referenceView: view)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFloatingViews(messages: Array<String>, color: UIColor?)
    {
        floatingAnimator = UIDynamicAnimator(referenceView: view)
        
        if color != nil
        {
            self.view.backgroundColor = color
        }
        else
        {
            self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        }
        
        
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = -200.0
        
        for message in messages
        {
            var messageView: FloatingView = FloatingView()
            
            messageView.loadMessageLabel(message)
            
            messageView.frame = CGRect(x: xPos, y: yPos, width: messageView.frame.width, height: messageView.frame.height)
            
            xPos += messageView.frame.width/2
            
            yPos += messageView.frame.height
            
            view.addSubview(messageView)
            
            floatingViews.addObject(messageView)
            
            var dynamicBehavior = UIDynamicItemBehavior(items: [messageView])
            dynamicBehavior.elasticity = CGFloat(Float(arc4random()) / Float(UINT32_MAX)/4)
            dynamicBehavior.allowsRotation = false
            floatingAnimator.addBehavior(dynamicBehavior)
            
//            var pushBehavior = UIPushBehavior(items: [messageView], mode: UIPushBehaviorMode.Continuous)
//            pushBehavior.magnitude = 1.0
//            floatingAnimator.addBehavior(pushBehavior)
        }
        
        let viewItems = floatingViews as [AnyObject]
        
        gravity = UIGravityBehavior(items: viewItems)
        
        viewCollision = UICollisionBehavior(items: viewItems)
        viewCollision.addBoundaryWithIdentifier("Ground", fromPoint: CGPointMake(view.frame.origin.x, view.frame.size.height), toPoint: CGPointMake(view.frame.origin.x+view.frame.size.width, view.frame.size.height))
        
        floatingAnimator.addBehavior(gravity)
        floatingAnimator.addBehavior(viewCollision)
        
    }
    
}

