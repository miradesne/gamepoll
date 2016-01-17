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

class GPQuestionTableViewCell: GPTableViewCell,ChartViewDelegate {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var pollResultsView: PieChartView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var questionType: QuestionType!
    var backgroundImageUrl: String?
    
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
                return "GPBinaryQuestionTableViewCell"
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
        self.innerView.layer.cornerRadius = 5
    }
    
    func extraSetup() {
        switch self.questionType! {
        case .InitialQuestion:
            self.setupInitialQuestionUI()
            break
        case .BinaryPoll:
            self.setupBinaryPollUI()
            break
        case .MultipleChoice:
            self.setupMultipleChoiceUI()
            break
        }
    }
    
    func setupInitialQuestionUI() {
        
    }
    
    func setupBinaryPollUI() {
        self.pollResultsView.hidden = true
        if let imageUrl = self.backgroundImageUrl {
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
    
    func setupMultipleChoiceUI() {
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func AnswerOne(sender: AnyObject) {
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
            self.pollResultsView.centerText = "booo"
            
            self.pollResultsView.drawHoleEnabled = true;
            self.pollResultsView.rotationAngle = 0.0;
            self.pollResultsView.rotationEnabled = true;
            self.pollResultsView.highlightPerTapEnabled = true;
            
            let l = self.pollResultsView.legend;
            l.position = ChartLegend.ChartLegendPosition.RightOfChart;
            l.xEntrySpace = 7.0;
            l.yEntrySpace = 0.0;
            l.yOffset = 0.0;
            
            self.pollResultsView.animate(xAxisDuration: 0.5)
        } else {
            // TODO: remove cell: delegate? reactive cocoa?
        }
    }
}
