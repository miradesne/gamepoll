//
//  GPAnswerButton.swift
//  gamepoll
//
//  Created by Mira Chen on 1/15/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit

class GPAnswerButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 0
        if self.backgroundColor != nil {
            self.setTitleColor(UIColor.gmpButtonWhiteColor(), forState: UIControlState.Normal)
        } else {
            self.setTitleColor(UIColor.gmpDarkTextColor(), forState: UIControlState.Normal)
        }
        self.titleLabel?.font = UIFont.systemFontOfSize(20.0)
        self.backgroundColor = self.backgroundColor != nil ? self.backgroundColor : UIColor.gmpButtonWhiteColor()
        self.layer.shadowColor = UIColor.gmpButtonWhiteShadowColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

}
