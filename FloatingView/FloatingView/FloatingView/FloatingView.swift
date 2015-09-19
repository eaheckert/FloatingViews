//
//  FloatingView.swift
//  FloatingView
//
//  Created by Eugene Heckert on 8/18/15.
//  Copyright (c) 2015 Eugene Heckert. All rights reserved.
//

import Foundation
import UIKit

protocol FloatingViewDelegate
{
    func floatViewSelected(messageText:String)
    func floatViewUnselected()
}

class FloatingView: UIView
{
    
    
    //MARK: IB Variables
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var fakeVaraible = NSMutableDictionary()
    
    //MARK: class Varaibles
    
    var delegate: FloatingViewDelegate?
    
    
    //MARK: Required Methods
    
    init()
    {
        super.init(frame: CGRectZero)
        NSBundle.mainBundle().loadNibNamed("FloatingView", owner: self, options: nil)
        self.addSubview(self.mainView)
        self.frame = self.mainView.frame
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        NSBundle.mainBundle().loadNibNamed("FloatingView", owner: self, options: nil)
        self.addSubview(self.mainView)
        self.frame = self.mainView.frame
    }
    
    override var frame: CGRect
    {
        get
        {
            return super.frame
        }
        set(newFrame)
        {
            super.frame = newFrame
            
            
            if (mainView != nil)
            {
                var frame = newFrame
                frame.origin = CGPointZero
                mainView.frame = frame
            }
            
        }
    }
    
    
    //MARK: Custom Methods
    
    func loadMessageLabel(message: String)
    {
        messageLabel.text = message
        let longPress = UILongPressGestureRecognizer(target: self, action: "onLongPress:")
        longPress.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPress)
    }
    
    
    //MARK: Gesture Methods
    
    func onLongPress(gestureRecongizer:UIGestureRecognizer)
    {
        if delegate == nil
        {
            return
        }
        
        switch gestureRecongizer.state
        {
        case UIGestureRecognizerState.Began:
            delegate?.floatViewSelected(messageLabel.text!)
        case UIGestureRecognizerState.Ended:
            delegate?.floatViewUnselected()
        default:
            return
        }
    }
}
