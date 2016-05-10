
//  Created by dip Kasyap on 2/17/16.
//  Copyright © 2016 Esig. All rights reserved.

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
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.whiteColor() {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.blackColor() {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var thumbColor : UIColor = UIColor(red: 0.961, green: 0.831, blue: 0.243, alpha: 1.00) {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1.00) {
        didSet {
            self.setUnderline(ofColor: borderColor, andSize: borderSize)
        }
    }
    
    @IBInspectable var font : UIFont! = UIFont.systemFontOfSize(12) {
        didSet {
            setFont()
        }
    }
    
    @IBInspectable var borderSize:CGFloat = 1.0 {
        didSet {
            self.setUnderline(ofColor: borderColor, andSize: borderSize)
        }
    }
    
    @IBInspectable var thumUnderLineSize:CGFloat = 10 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    func setupView(){
        backgroundColor = UIColor.clearColor()
        setupLabels()
        addIndividualItemConstraints(labels, mainView: self, padding: 0)
        insertSubview(thumbView, atIndex: 0)
    }
    
    func setBorder(){
        self.setUnderline(ofColor: borderColor, andSize: borderSize)
    }
    
    func setupLabels(){
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for index in 1...items.count {
            
            let label = UILabel(frame: CGRectMake(0, 5, 70, 40))
            label.text = items[index - 1]
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = UIFont(name: "Avenir-Black", size: 15)
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            labels.append(label)
        }
        
        addIndividualItemConstraints(labels, mainView: self, padding: 0)
    }
    
    func setViewForLabel(label: UILabel) {
        var oldFrame = label.bounds
        let newWidth = CGRectGetWidth(oldFrame) - 50
        oldFrame.size.width = newWidth
        label.frame = oldFrame
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        displayNewSelectedIndex()
        
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        let location = touch.locationInView(self)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerate() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex(){
        for (_, item) in labels.enumerate() {
            item.textColor = unselectedLabelColor
        }
        
        let label = labels[selectedIndex]
        label.textColor = selectedLabelColor
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            
            var newFrame = label.frame
            newFrame.origin.y = newFrame.height-self.thumUnderLineSize
            newFrame.size.height = self.thumUnderLineSize
            
            self.thumbView.frame = newFrame //label.frame
            
            }, completion: nil)
    }
    
    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {
        
        for (index, button) in items.enumerate() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nextButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: prevButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: firstItem, attribute: .Width, multiplier: 1.0  , constant: 0)
                
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
        underLine.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width, sized);
        underLine.backgroundColor = color.CGColor
        self.layer.addSublayer(underLine)
    }
    
}
