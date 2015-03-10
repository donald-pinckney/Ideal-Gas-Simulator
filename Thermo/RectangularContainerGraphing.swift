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
        switch(plotIndex) {
        case 0:
            return DPGraphTypeHistogramBar
        case 1:
            return DPGraphTypeContinuous
        default:
            fatalError("ERROR")
        }
    }
    
    func graphView(graphView: DPGraphView!, histogramHeightForStart start: CGFloat, end: CGFloat, onPlotWithIndex plotIndex: Int) -> CGFloat {
        let f = Double(dimens.count)
        let T = totalKE * 2 / f / (Double(N)*Kb)
        let m = particles[0].m
        let vp = sqrt(2 * Kb * T / m)
        
        let c = particles.filter({ p in
            let v = mag(p.v) / vp
            return v >= Double(start) && v < Double(end)
        }).count
        return CGFloat(c) / CGFloat(N) / (end - start)
    }
    
    func graphView(graphView: DPGraphView!, numberOfPointsForIndex plotIndex: Int) -> Int {
        return 5
    }
    
    func graphView(graphView: DPGraphView!, xyValueForPointIndex pointIndex: Int, forPlotIndex plotIndex: Int) -> CGPoint {
        return CGPoint(x: CGFloat(pointIndex - 2), y: CGFloat([0, -1, 1, -2, 2][pointIndex]))
    }
    
    func graphView(graphView: DPGraphView!, colorForPlotIndex plotIndex: UInt) -> UIColor! {
        switch(plotIndex) {
        case 0:
            return UIColor.redColor()
        case 1:
            return UIColor.redColor()
        default:
            fatalError("ERROR")
        }
    }
    
    
    func graphView(graphView: DPGraphView!, yValueForXValue x: CGFloat, onPlotWithIndex plotIndex: Int) -> CGFloat {
        let f = Double(dimens.count)

        let vvps = pow(Double(x) / sqrt(f / 3), 2)
        
        return CGFloat(4.0 / sqrt(M_PI) * vvps * exp(-vvps))
    }
    
    func numberOfPlotsInGraphView(graphView: DPGraphView!) -> Int {
        return N > 0 ? 2 : 0
    }
    
    func XAxisLabelInGraphView(graphView: DPGraphView!) -> String! {
        return "v / vp"
    }
    
    func YAxisLabelInGraphView(graphView: DPGraphView!) -> String! {
        return "Probability Density"
    }
}
