//
//  DPMovingAverageGraphView.swift
//  Thermo
//
//  Created by Donald Pinckney on 3/9/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation

class DPMovingAverageGraphView: DPGraphView {
    
    var storedMovingValues: [[[Double]]] = []
    var histogramIndices: [Int] = []
    
    var windowSize: Int = 1 {
        didSet {
            avgLenLabel.text = "Window size = \(windowSize)"
        }
    }
    var extendingWindowMode = false
    
    let avgLenLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let startBtn = UIButton()
        startBtn.setTitle("Start Avg", forState: .Normal)
        startBtn.setTitleColor(UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0), forState: .Normal)
        startBtn.addTarget(self, action: "startTapped:", forControlEvents: .TouchUpInside)
        startBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        startBtn.showsTouchWhenHighlighted = true
        addSubview(startBtn)
        
        let endBtn = UIButton()
        endBtn.setTitle("End Avg", forState: .Normal)
        endBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
        endBtn.addTarget(self, action: "endTapped:", forControlEvents: .TouchUpInside)
        endBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        endBtn.showsTouchWhenHighlighted = true
        addSubview(endBtn)
        
        avgLenLabel.text = "Window size = 1"
        avgLenLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(avgLenLabel)
        
        let views = ["startBtn" : startBtn, "endBtn" : endBtn, "avgLenLabel" : avgLenLabel]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[avgLenLabel]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        addConstraint(NSLayoutConstraint(item: endBtn, attribute: .CenterX, relatedBy: .Equal, toItem: startBtn, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: avgLenLabel, attribute: .CenterX, relatedBy: .Equal, toItem: startBtn, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[startBtn]-(30)-[endBtn]-(30)-[avgLenLabel]-(80)-|", options: .allZeros, metrics: nil, views: views))
        
    }
    
    func startTapped(b: UIButton) {
        extendingWindowMode = true
    }
    
    
    func endTapped(b: UIButton) {
        extendingWindowMode = false
    }
    
    override func getHistogramHeightForStart(start: CGFloat, end: CGFloat, onPlotWithIndex plotIndex: Int) -> CGFloat {
        
        
        let currentVal = super.getHistogramHeightForStart(start, end: end, onPlotWithIndex: plotIndex)
        
        let plotIndex = 0 // WARNING: FIXME: MAKE THIS NOT CONSTANT!!!
        storedMovingValues[storedMovingValues.count - 1][plotIndex].append(Double(currentVal))
        
        var sum = 0.0
        for timeSlot in storedMovingValues {
            sum += timeSlot[plotIndex][histogramIndices[plotIndex]]
        }
        
        histogramIndices[plotIndex]++
        
        return CGFloat(sum) / CGFloat(storedMovingValues.count)
    }
    
    override func startNewHistogramCycle() {
        if extendingWindowMode {
            windowSize++
        }
        
        let n = numHistPlots()
        histogramIndices = Array(count: n, repeatedValue: 0)
        storedMovingValues.append(Array(count: n, repeatedValue: []))
        
        if storedMovingValues.count > windowSize {
            storedMovingValues.removeAtIndex(0)
        }
        
        println(storedMovingValues.count)
    }
    
    func numHistPlots() -> Int {
        var count = 0
        for i in 0..<self.dataSource.numberOfPlotsInGraphView(self) {
            let t = dataSource.graphView(self, typeOfPlotForIndex: NSInteger(i))
            if t.value == DPGraphTypeHistogramBar.value || t.value == DPGraphTypeHistogramLine.value {
                count++
            }
        }
        return count
    }
}