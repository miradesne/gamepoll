//
//  GPTableViewCell.swift
//  gamepoll
//
//  Created by Mira Chen on 1/13/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit

class GPTableViewCell: UITableViewCell {
    
    class func reuseidentifier() ->String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
    }
}
