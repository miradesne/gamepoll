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
        let sampleQuestionType = GPQuestionTableViewCell.QuestionType.InitialQuestion
        let cell:GPQuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(sampleQuestionType.reuseIdentifier()) as! GPQuestionTableViewCell
        cell.questionType = sampleQuestionType
        cell.extraSetup()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
}

