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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFloatingViews(messages: Array<String>, color: UIColor?)
    {
        if color != nil
        {
            self.view.backgroundColor = color
        }
        else
        {
            self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        }
        
        
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 20.0
        
        for message in messages
        {
            var messageView: FloatingView = FloatingView()
            
            messageView.loadMessageLabel(message)
            
            messageView.frame = CGRect(x: xPos, y: yPos, width: messageView.frame.width, height: messageView.frame.height)
            
            xPos += messageView.frame.width/2
            
            yPos += messageView.frame.height
            
            view.addSubview(messageView)
        }
        
    }
    
}

