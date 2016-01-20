//
//  ViewController.swift
//  gamepoll
//
//  Created by Mira Chen on 1/11/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit

class GPViewController: UIViewController {

    @IBOutlet weak var homeFeedsTableView: UITableView!
    var feedTableDataSource: GPFeedTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableDataSource = GPFeedTableViewDataSource(tableView: self.homeFeedsTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

