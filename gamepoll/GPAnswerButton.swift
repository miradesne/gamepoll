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
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
//        self.layer.shadowRadius = 2
//        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
//        self.layer.shadowOpacity = 1
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

}
