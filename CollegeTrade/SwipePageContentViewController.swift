//
//  SwipePageContentViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14/10/30.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class SwipePageContentViewController: UIViewController
{
    
    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*if pageIndex == 0 {view.backgroundColor = UIColor.redColor()}
        if pageIndex == 1 {view.backgroundColor = UIColor.blueColor()}
        if pageIndex == 2 {view.backgroundColor = UIColor.greenColor()}
        if pageIndex == 3 {view.backgroundColor = UIColor.grayColor()}*/
        
        /*let label = UILabel(frame: CGRectMake(0, 0, view.frame.width, 200))
        label.textColor = UIColor.whiteColor()
        label.text = "shaoqing"
        label.textAlignment = .Center
        view.addSubview(label)*/
        
        let image = UIImage(named: self.imageFile) // imagFile
        let imageview = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.3))
        imageview.image = image
        view.addSubview(imageview)
        
        
        /*let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
        button.backgroundColor = UIColor(red: 138/255.0, green: 181/255.0, blue: 91/255.0, alpha: 1)
        button.setTitle(titleText, forState: UIControlState.Normal)
        button.addTarget(self, action: "Action:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)*/
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}