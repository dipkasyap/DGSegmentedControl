/******************************************************************************************************************
The MIT License (MIT) Copyright (c) 2014 Dip Kasyap (Devi Prasad Ghimire)

email:- dpd.ghimire@gmail.com github : https://github.com/dipkasyap/DGSegmentedControl

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE DGLocalization
******************************************************************************************************************/

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
