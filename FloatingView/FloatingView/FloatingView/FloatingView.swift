//
//  FloatingView.swift
//  FloatingView
//
//  Created by Eugene Heckert on 8/18/15.
//  Copyright (c) 2015 Eugene Heckert. All rights reserved.
//

import Foundation
import UIKit

class FloatingView: UIView
{
    
    
    //MARK: IB Varaibles
    
    @IBOutlet var mainView: UIView!
    
    
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
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FloatingView", owner: self, options: nil)
        self.addSubview(self.mainView)
        self.frame = self.mainView.frame
    }
}
