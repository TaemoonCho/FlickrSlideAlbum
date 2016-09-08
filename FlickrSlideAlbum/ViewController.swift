//
//  ViewController.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 19..
//  Copyright © 2016년 . All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftLoader

class ViewController: UIViewController {

    @IBOutlet weak var durationLabelView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLabel()
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerColor = .grayColor()
        config.titleTextColor = .grayColor()
        config.backgroundColor = .whiteColor()
        config.foregroundColor = .blackColor()
        config.foregroundAlpha = 0.35
        SwiftLoader.setConfig(config)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDurationButtontapped(sender: AnyObject) {
        ActionSheetMultipleStringPicker.showPickerWithTitle("Interval as seconds", rows: [
            ["1 second", "2 seconds", "3 seconds", "4 seconds", "5 seconds", "6 seconds", "7 seconds", "8 seconds", "9 seconds", "10 seconds" ]
            ], initialSelection: [4, 0], doneBlock: {
                picker, index, values  in
                if let i = index.first {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.duration = i.integerValue + 1
                    i.integerValue
                    self.updateLabel()
                }
                return
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func startButtonTapped(sender: AnyObject) {
        let feedManager = FeedManager.sharedInstance
        if !feedManager.isRunning {
            SwiftLoader.show(title: "Fetching feeds...", animated: true)
            print("running FeedManager")
            feedManager.runWithPreparedBlock { (prepared) -> Void in
                print("Now, FeedManager have prepared.")
                SwiftLoader.hide()
                if let imageSliderViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imageSliderViewController") {
                    self.showViewController(imageSliderViewController, sender: imageSliderViewController)
                }

            }
        }
    }
    
    func updateLabel() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let duration = appDelegate.duration
        self.durationLabelView.text = String(duration) + " seconds per each photos."
    }
}

