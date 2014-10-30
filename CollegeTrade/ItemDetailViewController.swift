//
//  ItemDetailViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class ItemDetailViewController: UIViewController {
    
    //@IBOutlet weak var moreButton: UIButton!
    var item: ItemForSell!
    var imageUrl: [String]!
    var firstImage: UIImage!
    
    var imageSet = [String: UIImage]()
    
    var imageViewSet = [UIImageView]()
    
    @IBOutlet var imagesScrollView: UIScrollView!
    @IBOutlet weak var itemName: UILabel!
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            imagesScrollView.scrollEnabled = true
            imagesScrollView.userInteractionEnabled = true
            imagesScrollView.showsVerticalScrollIndicator = true
            
            for i in 0...item.imageUrl.count - 1 {
                var position = CGFloat(i * 100.0)
                let imageView = UIImageView(frame: (CGRectMake(0, position, 100, 100)))
                imageView.image = UIImage(named:"randomcat1.png")
                imageViewSet.append(imageView)
                imagesScrollView.addSubview(imageView)
            }
            
            for i in 0...item.imageUrl.count - 1 {
                var url = item.imageUrl[i]
                if (imageSet[url] != nil) {
                    imageViewSet[i].image = imageSet[url]
                } else {
                    var imgURL: NSURL = NSURL(string: url)
                    
                    // Download an NSData representation of the image at the URL
                    let request: NSURLRequest = NSURLRequest(URL: imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                        if error == nil {
                            var image = UIImage(data: data)
                            
                            // Store the image in to our cache
                            self.imageSet[url] = image
                            dispatch_async(dispatch_get_main_queue(), {
                               self.imageViewSet[i].image = image
                                //var view = UIImageView(0,0,100,100)
                                //view.image = image
                                //self.imagesScrollView.addSubview(view)
                            })
                        }
                        else {
                            println("Error: \(error.localizedDescription)")
                        }
                    })
                }

            }
            
            
            itemName.text = "名称： \(self.item.title)"
            itemPrice.text = "价格： \(self.item.price)"
            
            
           // var pagedImageScrollView: PagedImageScrollView = PagedImageScrollView(frame: CGRect(x:0, y:0, width: 320,height: 120))
          //  pagedImageScrollView.setScrollViewContents(["randomcat1.png", "randomcat1.png"])
           // self.view.addSubview(pagedImageScrollView)
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
   



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
