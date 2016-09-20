//
//  ViewController.swift
//  DGSegmentedControl
//
//  Created by dip on 2/17/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: DGSegmentedControl!
    @IBOutlet weak var displayGround: UIView!
    @IBOutlet weak var info: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateSegmentedControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Action
    @IBAction func segmentValueChanged(_ sender: AnyObject) {
        
        if sender.selectedIndex == 0{
            self.displayGround.backgroundColor = UIColor.gray
            self.info.text = "First Segment selected"
        } else {
            self.displayGround.backgroundColor = UIColor(red: 0.761, green: 0.722, blue: 0.580, alpha: 1.00)
            self.info.text = "Second Segment selected"
        }
    }
    
    //MARK:- Segment control
    func decorateSegmentedControl(){
        
        segmentedControl.items = ["First Segment","Second Segment"]
        segmentedControl.font = UIFont(name: "Avenir-Black", size: 12)
        segmentedControl.borderColor = UIColor(red: 0.988, green: 0.820, blue: 0.447, alpha: 1.00)
        segmentedControl.selectedIndex = 0
        segmentedControl.borderSize = 2
        segmentedControl.thumbColor = UIColor(red: 0.988, green: 0.820, blue: 0.447, alpha: 1.00)
        segmentedControl.selectedLabelColor = UIColor.black
        segmentedControl.thumUnderLineSize = 8
        segmentedControl.font = UIFont.systemFont(ofSize: 18)
        self.segmentValueChanged(self.segmentedControl)
    }
    
}
