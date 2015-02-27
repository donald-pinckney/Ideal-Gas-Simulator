//
//  RectangularContainerGraphing.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/26/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation

extension RectangularContainer: DPGraphViewDataSource {
    
    func graphView(graphView: DPGraphView!, typeOfPlotForIndex plotIndex: Int) -> DPGraphType {
        return DPGraphTypeHistogramBar
    }
    
    func graphView(graphView: DPGraphView!, histogramHeightForStart start: CGFloat, end: CGFloat, onPlotWithIndex plotIndex: Int) -> CGFloat {
        var particles = self.particles
        let c = particles.filter({ p in
            let v = mag(p.v)
            return v >= Double(start) && v < Double(end)
        }).count
        return CGFloat(c)
    }
    
    func graphView(graphView: DPGraphView!, numberOfPointsForIndex plotIndex: Int) -> Int {
        return 5
    }
    
    func graphView(graphView: DPGraphView!, xyValueForPointIndex pointIndex: Int, forPlotIndex plotIndex: Int) -> CGPoint {
        return CGPoint(x: CGFloat(pointIndex - 2), y: CGFloat([0, -1, 1, -2, 2][pointIndex]))
    }
    
    
    func graphView(graphView: DPGraphView!, yValueForXValue x: CGFloat, onPlotWithIndex plotIndex: Int) -> CGFloat {
        return x*x
    }
    
    func numberOfPlotsInGraphView(graphView: DPGraphView!) -> Int {
        return 1
    }
    
    func XAxisLabelInGraphView(graphView: DPGraphView!) -> String! {
        return "X"
    }
    
    func YAxisLabelInGraphView(graphView: DPGraphView!) -> String! {
        return "Y"
    }
}
