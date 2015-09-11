//
//  ViewController.swift
//  FloatingView
//
//  Created by Eugene Heckert on 8/17/15.
//  Copyright (c) 2015 Eugene Heckert. All rights reserved.
//

import UIKit

class ViewController: UIViewController
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

    @IBAction func onShowFloatingViews(sender: AnyObject)
    {
        var vc: FloatingViewController = FloatingViewController()
        
        self.addChildViewController(vc)
        
        self.view.addSubview(vc.view)
        
        vc.createFloatingViews(["Goto Gym","Cook Dinner","Cook Dinner","Cook Dinner","Cook Dinner","Cook Dinner","Cook Dinner","Cook Dinner","Cook Dinner","go to the movies", "do homework"], color:nil)
    }

}

