//
//  SwipePageViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14/10/30.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//


import UIKit

class SwipePageViewController : UIPageViewController, UIPageViewControllerDataSource
{
    
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["1","2","3","4"]
    var pageImages : Array<String> = ["randomcat1.png", "randomcat1.png", "randomcat1.png", "randomcat1.png"]
    var currentIndex : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pageViewController =    UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal,  options: nil)
        pageViewController!.dataSource = self
      //  pageViewController.transitionStyle = UIPageViewControllerTransitionStyle.PageCurl
      //  pageViewController.spineLocation = UIPageViewControllerSpineLocation.Min
        
        let startingViewController: SwipePageContentViewController = viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        pageViewController!.view.tintColor = UIColor.redColor()
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as SwipePageContentViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            index += pageTitles.count
            //return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as SwipePageContentViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count) {
            index = 0
            //return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> SwipePageContentViewController?
    {
        if self.pageTitles.count == 0 || index >= self.pageTitles.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = SwipePageContentViewController()
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.titleText = pageTitles[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
}