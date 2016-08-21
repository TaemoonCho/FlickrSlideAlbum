//
//  ImageSliderViewController.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 21..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeImage()
        self.startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let duration = appDelegate.duration
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(duration), target: self, selector: Selector("changeImage"), userInfo: nil, repeats: true)
        
    }
    
    func changeImage() {
        FeedManager.sharedInstance.getNextFeedWithBlock { (isDone, feed) -> Void in
            dispatch_async(dispatch_get_main_queue(),{
                if let image = feed?.image {
                    self.imageView.fadeOutAndIn(0.7, beforeCompleteBlock: { () -> Void in
                        self.imageView.image = image
                    })
                }
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
