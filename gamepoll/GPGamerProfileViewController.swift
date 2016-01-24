//
//  GPGameProfileViewController.swift
//  
//
//  Created by Mira Chen on 1/12/16.
//
//

import UIKit
import Charts

class GPGamerProfileViewController: UIViewController {
    var traits: [String]!
    
    @IBOutlet weak var parentScrollView: UIScrollView!
    
    @IBOutlet weak var radarChartView: RadarChartView!
    @IBAction func dismissSelf(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //round up scoll view corners
        parentScrollView.layer.cornerRadius = 10
        parentScrollView.layer.masksToBounds = true
        
        radarChartView.noDataText = "no data"
        //offscreen
        radarChartView.setDescriptionTextPosition(x: 1000, y: 1000)
        traits = ["Graphics", "Story", "Sound", "Learning Curve", "Novelty"]
        let scores = [3.9, 4.0, 1.0, 3.5, 5.0]
        
        setData(traits, scores: scores)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(traits: [String], scores: [Double]) {
        var yAxisScores: [ChartDataEntry] = [ChartDataEntry]()
        var xAxisTraits: [String] = [String]()

        for var i = 0; i < scores.count; i++ {
            yAxisScores.append(ChartDataEntry(value: scores[i], xIndex: i))
        }
        
        for var i = 0; i < traits.count; i++ {
            xAxisTraits.append(traits[i])
        }
        
        let dataset: RadarChartDataSet = RadarChartDataSet(yVals: yAxisScores, label: "Traits")
        dataset.drawFilledEnabled = true
        dataset.lineWidth = 2.0
        dataset.colors = [UIColor.flatGreenSeaColor()]
        dataset.setDrawHighlightIndicators(false)
        dataset.drawValuesEnabled = false

        // Configure Radar Chart
        radarChartView.yAxis.customAxisMax = 5.0
        radarChartView.yAxis.customAxisMin = 0
        radarChartView.yAxis.startAtZeroEnabled = false
        radarChartView.yAxis.drawLabelsEnabled = false
        radarChartView.userInteractionEnabled = false

        let data: RadarChartData = RadarChartData(xVals: xAxisTraits, dataSets: [dataset])
        radarChartView.data = data
        
        let bgColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1)
        radarChartView.backgroundColor = bgColor
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
