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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateSegmentedControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func decorateSegmentedControl(){
        
        segmentedControl.items = ["First Segment","Second Segment"]
        segmentedControl.font = UIFont(name: "Avenir-Black", size: 12)
        segmentedControl.borderColor = UIColor(red: 0.988, green: 0.820, blue: 0.447, alpha: 1.00)
        segmentedControl.selectedIndex = 1
        segmentedControl.borderSize = 2
        segmentedControl.thumbColor = UIColor(red: 0.988, green: 0.820, blue: 0.447, alpha: 1.00)
        segmentedControl.selectedLabelColor = UIColor.blackColor()
        segmentedControl.thumUnderLineSize = 8
        // segmentedControl.addTarget(self, action: "segmentValueChanged:", forControlEvents: .ValueChanged)
    }
    
}

