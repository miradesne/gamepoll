//
//  GPGameProfileViewController.swift
//  
//
//  Created by Mira Chen on 1/12/16.
//
//

import UIKit
import Charts

class GPGameProfileViewController: UIViewController {
    var traits: [String]!
    
    
    @IBOutlet weak var radarChartView: RadarChartView!
    @IBAction func dismissSelf(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radarChartView.noDataText = "no data"
//        radarChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        traits = ["Graphics", "Story", "Sound", "Learning Curve", "Newness"]
        let scores = [4.9, 4.0, 5.0, 3.5, 5.0]
        
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
        
        let dataset: RadarChartDataSet = RadarChartDataSet(yVals: yAxisScores, label: "Game Profile")
        dataset.drawFilledEnabled = true
        dataset.lineWidth = 2.0
        dataset.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        let data: RadarChartData = RadarChartData(xVals: xAxisTraits, dataSets: [dataset])
        
        radarChartView.data = data
        

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
