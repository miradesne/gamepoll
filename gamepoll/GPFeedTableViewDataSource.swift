//
//  GPFeedTableViewDataSource.swift
//  gamepoll
//
//  Created by Mira Chen on 1/16/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit

class GPFeedTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, GPQuestionTableViewCellDelegate {
    
    weak var tableview: UITableView?
    var dataArray: [Dictionary<String, AnyObject?>]?
    
    init(tableView: UITableView) {
        super.init()
        self.tableview = tableView
        self.tableview?.delegate = self
        self.tableview?.dataSource = self
        self.dataArray = [["QuestionType" : GPQuestionTableViewCell.QuestionType.InitialQuestion.rawValue, "Question" : "Have you played The Last Of Us?"],
            ["QuestionType" : GPQuestionTableViewCell.QuestionType.BinaryPoll.rawValue, "Question" : "Do you think The Last Of Us has a good story?"],
            ["QuestionType" : GPQuestionTableViewCell.QuestionType.MultipleChoice.rawValue, "Question" : "What's your favorite thing in The Last Of Us?", "Choices" : ["Graphics",	"Story",	"Gameplay",	"Sound"]]]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row > self.dataArray?.count {
            return UITableViewCell()
        }
        let sampleQuestionType = GPQuestionTableViewCell.QuestionType(rawValue: self.dataArray?[indexPath.row]["QuestionType"] as! Int)
        let cell:GPQuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(sampleQuestionType!.reuseIdentifier()) as! GPQuestionTableViewCell
        cell.questionType = sampleQuestionType
        cell.extraSetup((self.dataArray?[indexPath.row])!)
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
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
