<p align="center"> 
<img src="https://user-images.githubusercontent.com/12591229/36713674-ded0ca38-1bb6-11e8-8448-1e18b7d345cf.png">
</p>

# DGSegmentedControl
 Custom Segmented Control that has Full Feature customization on need of customisation.
 ![dgsegmentedconrtol](https://user-images.githubusercontent.com/12591229/30465794-24301d30-99f9-11e7-8be5-920bde161abc.png)
# Supports Swift 3.0
For Swift 2.X use previous release

# Usage
1. Drag DGSegmentedControl folder in to your project.

2. Add UIView on storyboard which will work as segmented control for you.

3. Assign DGSegmentedControl class to that View from Identity Inspector

4. Drag outlet to Your View Controller and access like in demo project.

        //IBOutlet
         @IBOutlet weak var segmentedControl: DGSegmentedControl!
      
         override func viewDidLoad() {
           super.viewDidLoad()
           //setup
           setupSegments()
       }
       
       //setup
         private func setupSegments() {
        
            segmentControl.items = ["First Segment","Second Segment"]
            segmentControl.font = UIFont(name: "Avenir-Black", size: 12)
            segmentControl.borderColor = AppConstants.Color.mportGreen
            segmentControl.selectedIndex = 0
            segmentControl.borderSize = 2
            segmentControl.thumbColor = AppConstants.Color.mportGreen
            segmentControl.selectedLabelColor = AppConstants.Color.mportGreen
            segmentControl.thumUnderLineSize = 8
            segmentControl.font = UIFont.systemFont(ofSize: 18)
            segmentControl.addTarget(self, action:#selector(segmentValueChanged(segmentControl:)), for: .valueChanged)
        }

        //MARK:- Actions
         @objc func segmentValueChanged(segmentControl: DGSegmentedControl){
            if segmentControl.selectedIndex == 0 {
            }
        }

# Licence

The MIT License (MIT) Copyright (c) 2014 Dip Kasyap (Devi Prasad Ghimire)

email:- dpd.ghimire@gmail.com github : https://github.com/dipkasyap/DGSegmentedControl

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE DGLocalization

