//
//  ViewController.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 19..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ViewController: UIViewController {

    @IBOutlet weak var setDurationButton: UIButton!
    @IBOutlet weak var durationLabelView: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pivkerView: UIPickerView!
    
    var duration = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLabel()
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
                    self.duration = i.integerValue + 1
                    i.integerValue
                    self.updateLabel()
                }
                return
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBOutlet weak var startButtonTapped: UIButton!
    func updateLabel() {
        self.durationLabelView.text = String(self.duration) + " seconds per each photos."
    }

    //MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    //MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row) + "Sec"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // TODO
    }
}

