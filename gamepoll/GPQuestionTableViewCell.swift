//
//  GPQuestionTableViewCell.swift
//  gamepoll
//
//  Created by Mira Chen on 1/12/16.
//  Copyright © 2016 gamepollstudio. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import ReactiveCocoa
import UIColor_FlatColors

protocol GPQuestionTableViewCellDelegate {
    func cell(cell:GPQuestionTableViewCell, answeredIndex:Int)
}

class GPQuestionTableViewCell: GPTableViewCell, ChartViewDelegate {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var pollResultsView: PieChartView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: GPAnswerButton!
    @IBOutlet weak var answerTwo: GPAnswerButton!
    @IBOutlet weak var answerThree: GPAnswerButton!
    @IBOutlet weak var answerFour: GPAnswerButton!
    
    var questionType: QuestionType!
    var backgroundImageUrl: String?
    var delegate: GPQuestionTableViewCellDelegate?
    
    enum QuestionType: Int {
        
        case InitialQuestion, BinaryPoll, MultipleChoice
        func showAnswer() -> Bool {
            switch self {
            case .InitialQuestion:
                return false
            case .BinaryPoll:
                return true
            case .MultipleChoice:
                return true
            }
        }
        
        func reuseIdentifier() -> String {
            switch self {
            case .InitialQuestion:
                return "GPInitialQuestionTableViewCell"
            case .BinaryPoll:
                return "GPBinaryPollTableViewCell"
            case .MultipleChoice:
                return "GPMultipleChoiceTableViewCell"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupUI() {
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        // Initialization code
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowColor = UIColor.grayColor().CGColor
        self.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowRadius = 1
        self.innerView.layer.cornerRadius = 8
        if (self.backgroundImageView == nil) || (self.backgroundImageView.image == nil) {
            self.questionLabel.textColor = UIColor.gmpDarkTextColor()
        } else {
            self.questionLabel.textColor = UIColor.gmpWhiteTextColor()
        }
        self.questionLabel.font = UIFont.init(name: "SanFranciscoDisplay-Thin", size: 20.0)
    }
    
    func extraSetup(data:Dictionary<String, AnyObject?>) {
        guard let questionString = data["Question"] as? String else {
            print("data is missing question! failed.")
            return
        }
        self.questionLabel.text = questionString
        switch self.questionType! {
        case .InitialQuestion:
            self.setupInitialQuestionUI(data)
            break
        case .BinaryPoll:
            self.setupBinaryPollUI(data)
            break
        case .MultipleChoice:
            self.setupMultipleChoiceUI(data)
            break
        }
    }
    
    func setupInitialQuestionUI(data:Dictionary<String, AnyObject?>) {
        
    }
    
    func setupBinaryPollUI(data:Dictionary<String, AnyObject?>) {
        self.pollResultsView.hidden = true
        if let imageUrl = data["imageUrl"] as? String {
            request(.GET, imageUrl)
            .responseData({ dataResponse in
                guard let imageData = dataResponse.data else {
                        print("error! data is nil!")
                        return 
                }
                self.backgroundImageView.image = UIImage(data: imageData)
            })
            
        }
    }
    
    func setupMultipleChoiceUI(data:Dictionary<String, AnyObject?>) {
        self.pollResultsView.hidden = true
        guard let answerStrings = data["Choices"] as? [String] else {
            print("error! no choices!!")
            return
        }
        answerOne .setTitle(answerStrings[0], forState: UIControlState.Normal)
        answerTwo .setTitle(answerStrings[1], forState: UIControlState.Normal)
        answerThree .setTitle(answerStrings[2], forState: UIControlState.Normal)
        answerFour .setTitle(answerStrings[3], forState: UIControlState.Normal)
        if let imageUrl = data["imageUrl"] as? String {
            request(.GET, imageUrl)
                .responseData({ dataResponse in
                    guard let imageData = dataResponse.data else {
                        print("error! data is nil!")
                        return
                    }
                    self.backgroundImageView.image = UIImage(data: imageData)
                })
            
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func AnswerOne(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.cell(self, answeredIndex: 0)
        }
    }
    
    func showAnswerWithData() {
        //TO DO: a graph with data in it.
        if self.questionType.showAnswer() {
            self.pollResultsView.hidden = false
            self.pollResultsView.delegate = self;
            
            self.pollResultsView.usePercentValuesEnabled = true;
            self.pollResultsView.holeTransparent = true;
            self.pollResultsView.holeRadiusPercent = 0.58;
            self.pollResultsView.transparentCircleRadiusPercent = 0.61;
            self.pollResultsView.descriptionText = "";
            
            self.pollResultsView.drawCenterTextEnabled = true;
            //        var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy()
            //
            //        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"iOS Charts\nby Daniel Cohen Gindi"];
            //        [centerText setAttributes:@{
            //        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f],
            //        NSParagraphStyleAttributeName: paragraphStyle
            //        } range:NSMakeRange(0, centerText.length)];
            //        [centerText addAttributes:@{
            //        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f],
            //        NSForegroundColorAttributeName: UIColor.grayColor
            //        } range:NSMakeRange(10, centerText.length - 10)];
            //        [centerText addAttributes:@{
            //        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:10.f],
            //        NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
            //        } range:NSMakeRange(centerText.length - 19, 19)];
            self.pollResultsView.centerText = "Poll Results"
            
            self.pollResultsView.drawHoleEnabled = true;
            self.pollResultsView.rotationAngle = 0.0;
            self.pollResultsView.rotationEnabled = true;
            self.pollResultsView.highlightPerTapEnabled = true;
            
            var dataEntries: [ChartDataEntry] = []
            
            let dataPoints = ["no", "yes"]
            let values = [20.0, 15.0]
            
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
                dataEntries.append(dataEntry)
            }
            
            let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
            let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
            self.pollResultsView.data = pieChartData
            
            var colors: [UIColor] = []
           
            colors.append(UIColor.flatEmeraldColor())
            colors.append(UIColor.flatNephritisColor())

            pieChartDataSet.colors = colors
            
            let l = self.pollResultsView.legend;
            l.position = ChartLegend.ChartLegendPosition.RightOfChart
            l.xEntrySpace = 7.0
            l.yEntrySpace = 0.0
            l.yOffset = 0.0
            // I want to hide the label
            l.enabled = false
            
            self.pollResultsView.animate(xAxisDuration: 0.5)
        }
    }
}
