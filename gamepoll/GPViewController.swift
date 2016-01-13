//
//  ViewController.swift
//  gamepoll
//
//  Created by Mira Chen on 1/11/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit

class GPViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var homeFeedsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:GPQuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(GPQuestionTableViewCell.reuseidentifier()) as! GPQuestionTableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 157
    }
}

