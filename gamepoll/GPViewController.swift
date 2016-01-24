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
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "profileIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "showGamerProfile")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "searchIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func setUpGenericUIForApp() {
        UINavigationBar.appearance().barTintColor = UIColor.gmpBackgroundBlackColor()
    }
    
    func showGamerProfile() {
        self.performSegueWithIdentifier("showGamerProfile", sender: self)
    }
}

