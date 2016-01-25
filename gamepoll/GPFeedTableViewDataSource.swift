//
//  GPFeedTableViewDataSource.swift
//  gamepoll
//
//  Created by Mira Chen on 1/16/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit
import Parse

class GPFeedTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, GPQuestionTableViewCellDelegate {
    
    weak var tableview: UITableView?
    var dataArray: [Dictionary<String, AnyObject?>]?
    
    init(tableView: UITableView) {
        super.init()
        self.tableview = tableView
        self.tableview?.delegate = self
        self.tableview?.dataSource = self
        self.dataArray = []

        // Get Questions: default is 100
        let query = PFQuery(className:Constants.QUESTION)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        var questionData = [Constants.QUESTION_TYPE: object.valueForKey(Constants.QUESTION_TYPE)?.integerValue,
                            Constants.QUESTION: object.valueForKey(Constants.QUESTION)]
                        
                        if (object.valueForKey(Constants.QUESTION_TYPE)?.integerValue == 2) {
                            questionData[Constants.QUESTION_CHOICES] = object.valueForKey(Constants.QUESTION_CHOICES)
                        }
                        
                        self.dataArray?.append(questionData)
                    }
                    self.tableview?.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row > self.dataArray?.count {
            return UITableViewCell()
        }
        let sampleQuestionType = GPQuestionTableViewCell.QuestionType(rawValue: self.dataArray?[indexPath.row][Constants.QUESTION_TYPE] as! Int)
        let cell:GPQuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(sampleQuestionType!.reuseIdentifier()) as! GPQuestionTableViewCell
        cell.questionType = sampleQuestionType
        cell.extraSetup((self.dataArray?[indexPath.row])!)
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let questionType = GPQuestionTableViewCell.QuestionType(rawValue: self.dataArray?[indexPath.row][Constants.QUESTION_TYPE] as! Int) {
            return questionType.cellHeight()
        } else {
            return 250
        }
    }
    
    func cell(cell:GPQuestionTableViewCell, answeredIndex:Int) {
        if cell.questionType.showAnswer() {
            cell.showAnswerWithData()
        } else {
            self.dataArray?.removeAtIndex(answeredIndex)
            self.tableview?.beginUpdates()
            let indexPath: NSIndexPath = (self.tableview?.indexPathForCell(cell))!
            self.tableview?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableview?.endUpdates()
        }
    }
}
