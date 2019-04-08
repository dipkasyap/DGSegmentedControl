/******************************************************************************************************************
 The MIT License (MIT) Copyright (c) 2014 Dip Kasyap (Devi Prasad Ghimire)
 
 email:- dpd.ghimire@gmail.com github : https://github.com/dipkasyap/DGSegmentedControl
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE DGLocalization
 ******************************************************************************************************************/

import UIKit

@IBDesignable class DGSegmentedControl: UIControl {
    
    private var labels = [UILabel]()
    
    var thumbView = UIView()
    var underLine = UIView()
    
    var items: [String] = ["Item 1", "Item 2"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.black {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var thumbColor : UIColor = UIColor(red: 0.961, green: 0.831, blue: 0.243, alpha: 1.00) {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var tabBorderColor : UIColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1.00) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var font: UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }
    
    @IBInspectable var borderSize: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var thumUnderLineSize:CGFloat = 4 {
        didSet {
            layoutSubviews()
        }
    }
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupThumb()
        displayNewSelectedIndex()
    }
    
    
    //MARK:- setup
    func setupView(){
        setupLabels()
        addIndividualItemConstraints(items: labels, mainView: self, padding: 0)
        insertSubview(thumbView, at: 0)
    }
    
    private func setupThumb() {
        var thumbFrame = self.bounds
        let newWidth = thumbFrame.width / CGFloat(items.count)
        thumbFrame.size.width = newWidth
        thumbFrame.origin.y  = thumbFrame.height - self.thumUnderLineSize
        thumbFrame.size.height = thumUnderLineSize
        thumbView.frame = thumbFrame
        thumbView.backgroundColor = thumbColor
    }
    
    func setBorder(){
        self.setUnderline(ofColor: tabBorderColor, andSize: borderSize)
    }
    
    func setupLabels(){
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            
            let label = UILabel(frame:CGRect(x: 0, y: 5, width: 70, height: 40))
            label.text = items[index - 1]
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.font = font
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            labels.append(label)
        }
        
        addIndividualItemConstraints(items: labels, mainView: self, padding: 0)
    }
    
    func setViewForLabel(label: UILabel) {
        var oldFrame = label.bounds
        let newWidth = oldFrame.width - 50
        oldFrame.size.width = newWidth
        label.frame = oldFrame        
    }
    

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex(){
        for (_, item) in labels.enumerated() {
            item.textColor = unselectedLabelColor
        }
        
        let label = labels[selectedIndex]
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            
            label.textColor = self.selectedLabelColor
            
            var newFrame = label.frame
            newFrame.origin.y = newFrame.height - self.thumUnderLineSize
            newFrame.size.height = self.thumUnderLineSize
            
            self.thumbView.frame = newFrame //label.frame
            
        }, completion: nil)
    }
    
    //MARK:- constraints
    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nextButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: prevButton, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    func setSelectedColors(){
        for item in labels {
            item.textColor = unselectedLabelColor
        }
        
        if labels.count > 0 {
            labels[0].textColor = selectedLabelColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
    func setFont(){
        for item in labels {
            item.font = font
        }
    }
}

extension UIView {
    
    func setUnderline(ofColor color:UIColor, andSize sized:CGFloat){
        //Making UnderLIne BOrder on UitextFld
        let underLine = CALayer()
        underLine.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: sized)
        underLine.backgroundColor = color.cgColor
        self.layer.addSublayer(underLine)
    }
    
}
