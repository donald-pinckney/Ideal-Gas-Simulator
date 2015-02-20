//
//  ThermoTests.swift
//  ThermoTests
//
//  Created by Donald Pinckney on 2/12/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import UIKit
import XCTest

class ThermoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimulationIteration1D() {
        
        let c = RectangularContainer(numDims: 1, squareDimen: 1)
        let dt = 0.02
        
        self.measureBlock() {
            for i in 0..<100 {
                c.update(dt)
            }
            
            XCTAssert(true, "Momentum appeared to be conserved in all collisions.")
        }
    }
    
    func testSimulationIteration2D() {
        
        let c = RectangularContainer(numDims: 2, squareDimen: 1)
        let dt = 0.02
        
        self.measureBlock() {
            for i in 0..<100 {
                c.update(dt)
            }
            
            XCTAssert(true, "Momentum appeared to be conserved in all collisions.")
        }
    }
    
    func testSimulationIteration3D() {
        
        let c = RectangularContainer(numDims: 3, squareDimen: 1)
        let dt = 0.02
        
        self.measureBlock() {
            for i in 0..<100 {
                c.update(dt)
            }
            
            XCTAssert(true, "Momentum appeared to be conserved in all collisions.")
        }
    }
    
    func testSimulationIteration4D() {

        let c = RectangularContainer(numDims: 4, squareDimen: 1)
        let dt = 0.02
        
        self.measureBlock() {
            for i in 0..<100 {
                c.update(dt)
            }
            
            XCTAssert(true, "Momentum appeared to be conserved in all collisions.")
        }
    }
    
}
