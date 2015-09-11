//
//  FloatView.swift
//  FloatingView
//
//  Created by Eugene Heckert on 8/17/15.
//  Copyright (c) 2015 Eugene Heckert. All rights reserved.
//

import Foundation
import UIKit

class FloatingViewController: UIViewController, FloatingViewDelegate
{
    private var floatingAnimator: UIDynamicAnimator!
    private var gravity: UIGravityBehavior!
    private var viewCollision: UICollisionBehavior!
    private var floatingViews = NSMutableArray()
    private var floatingViewDict = NSMutableDictionary()
    
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
            
            messageView.frame = CGRect(x: 0, y: 0, width: messageView.frame.width, height: messageView.frame.height)
            
            let messageHalfWidth = ((messageView.frame.size.width/2) + 10)
            
            xPos = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(messageHalfWidth - (view.frame.size.width-messageHalfWidth)) + min(messageHalfWidth, (view.frame.size.width-messageHalfWidth))
            
            messageView.center = CGPointMake(xPos, yPos)
            
            messageView.delegate = self
            
            view.addSubview(messageView)
            
            floatingViews.addObject(messageView)
            
            var viewArray = NSMutableArray()
            
            if floatingViewDict[message] != nil
            {
                viewArray = floatingViewDict[message] as! NSMutableArray
            }
            
            viewArray.addObject(messageView)
            
            floatingViewDict.setObject(viewArray, forKey: message)
            
            var dynamicBehavior = UIDynamicItemBehavior(items: [messageView])
            dynamicBehavior.elasticity = CGFloat(Float(arc4random()) / Float(UINT32_MAX)/4)
            dynamicBehavior.allowsRotation = false
            floatingAnimator.addBehavior(dynamicBehavior)
        }
        
        let viewItems = floatingViews as [AnyObject]
        
        gravity = UIGravityBehavior(items: viewItems)
        
        viewCollision = UICollisionBehavior(items: viewItems)
        viewCollision.addBoundaryWithIdentifier("Ground", fromPoint: CGPointMake(view.frame.origin.x, view.frame.size.height), toPoint: CGPointMake(view.frame.origin.x+view.frame.size.width, view.frame.size.height))
        
        floatingAnimator.addBehavior(gravity)
        floatingAnimator.addBehavior(viewCollision)
        
    }
    
    func floatViewSelected(messageText: String)
    {
        println(messageText)
        for key in floatingViewDict.allKeys
        {
            if !key.isEqualToString(messageText)
            {
                let viewArray = floatingViewDict[String(key as! NSString)] as! NSArray
                
                for( var i = 0; i < viewArray.count;i++)
                {
                    let view = viewArray[i] as! FloatingView
                    view.alpha = 0.5
                }
            }
        }
    }
    
    func floatViewUnselected()
    {
        for key in floatingViewDict.allKeys
        {
            let viewArray = floatingViewDict[String(key as! NSString)] as! NSArray
            
            for( var i = 0; i < viewArray.count;i++)
            {
                let view = viewArray[i] as! FloatingView
                view.alpha = 1.0
            }
        }
    }
    
}

